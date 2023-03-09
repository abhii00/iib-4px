function g = mpcpd()
    %mpc-pd parameters
    loop = 'cube0_mpcpd';
    model = 'cube0_mpcpdmodel';
    scmodel = 'cube0';
    pred_horizon = 400;
    
    %learning parameters
    g = [1; 1; 1; 50; 50; 50];
    dgs = 0.05*ones(6, 1);
    iterations = 50;
    eta = 0.5;

    %extract states from current sim
    set_param(loop, 'SimulationCommand', 'WriteDataLogs');
    out_cur = evalin('base', 'out');
    states_cur = out_cur.states;

    %replace with correct models
    for i = 1:numElements(states_cur)
        nm = states_cur{i}.Name;
        nm_new = strrep(nm, scmodel, [scmodel '_copy']);
        val_new = getsamples(states_cur{i}.Values, length(states_cur{i}.Values.Time));
        bp = states_cur{i}.BlockPath;
        bp_new = Simulink.BlockPath({strrep(bp.getBlock(1), loop, model), ...
                                    strrep(bp.getBlock(2), scmodel, [scmodel '_copy'])});
        states_cur{i}.Name = nm_new;
        states_cur{i}.Values = val_new;
        states_cur{i}.BlockPath = bp_new;
    end

    %perform gradient descent
    disp('==================================')
    t_start = tic;
    C0s = [];
    i = 1;
    gradient_descent = true;
    while (gradient_descent)
        disp('----------------------------------')
        disp(['Trying Control Gains = ' num2str(g.') ' for iteration #' num2str(i)])

        %extend dg into matrix, and set up dg
        dgs_mat = diag(dgs);
        Cs = zeros(6, 1);
        gradC = ones(6, 1);

        %C(g)
        out_pred = predict(model, states_cur, pred_horizon, g);
        C0 = evaluatecost(out_pred, g);
        disp(['Evaluated C(0) = ' num2str(C0)])
        C0s = [C0s C0];

        for n=1:length(dgs)
            %C(g+dg)
            g_test = g + dgs_mat(:, n);
            out_pred = predict(model, states_cur, pred_horizon, g_test);
            Cs(n) = evaluatecost(out_pred, g_test);
            disp(['Evaluated C(' num2str(n) ') = ' num2str(Cs(n)) ' with g = ' num2str(g_test.')])
        end

        %evaluate gradC
        gradC = (Cs-C0*ones(6, 1))./dgs;
        gradC = gradC/norm(gradC);
        disp(['Evaluated gradC = ' num2str(gradC.')])
        
        %step down gradient
        g = g - eta*gradC;

        %cap negative gain
        g = max(g, 0);

        %check for completion
        i = i + 1;
        if (all(gradC == 0) || (i >= iterations))
            gradient_descent = false;
        end
    end

    %end gradient descent
    disp('----------------------------------')
    disp(['Time Taken = ' num2str(toc(t_start)) 's'])
    disp(['Gradient Descent Finished at iteration #' num2str(i)])
    disp(['Final Control Gains = ' num2str(g.')])
    hold on
    plot(1:length(C0s), C0s);

    function out_pred = predict(model, states_cur, pred_horizon, g_test)
        %add values of k and lambda to base workspace
        assignin('base', 'ks', g_test(1:3));
        assignin('base', 'lambdas', g_test(4:6));
        
        %add values of initial states to workspace
        assignin('base', 'states_cur', states_cur);

        %sim
        out_pred = sim(model, ...
                       'StopTime', num2str(pred_horizon), ...
                       'LoadInitialState', 'on', 'InitialState', 'states_cur');
    end

    function C = evaluatecost(output)
        %get output data
        ts = output.tout;
        qs_acc = getdatasamples(output.q_acc, 1:length(ts));
        qs_tar = getdatasamples(output.q_tar, 1:length(ts));

        %calculate error
        es = zeros(size(ts));
        for j = 1:length(ts)
            qm_acc = quatconvert(qs_acc(:, :, j), 'simulink', 'matlab');
            qm_tar = quatconvert(qs_tar(:, :, j), 'simulink', 'matlab');
            es(j) = dist(qm_tar, qm_acc);
        end

        %calculate cost
        cost = cumtrapz(ts, es.^2);
        C = cost(end);

        %cap negative cost
        if C < 0
            C = 0;
            disp('WARNING: Negative Cost')
        end
    end
end 