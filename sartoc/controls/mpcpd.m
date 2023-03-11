function g = mpcpd()
    %mpc-pd parameters
    loop_real = evalin('base', 'loop_real');
    loop_model = evalin('base', 'loop_model');
    sc_real = evalin('base', 'sc_real');
    sc_model = evalin('base', 'sc_model');
    pred_horizon = evalin('base', 'pred_horizon');
    
    %learning parameters
    g = [1; 1; 1; 50; 50; 50];
    dgs = 0.05*ones(6, 1);
    iterations = 1;
    eta = 4;

    %extract states from current sim
    set_param(loop_real, 'SimulationCommand', 'WriteDataLogs');
    out_cur = evalin('base', 'out');
    states_cur = out_cur.states;

    %replace with correct models
    for i = 1:numElements(states_cur)
        nm = states_cur{i}.Name;
        nm_new = strrep(nm, sc_real, sc_model);
        val_new = getsamples(states_cur{i}.Values, length(states_cur{i}.Values.Time));
        bp = states_cur{i}.BlockPath;
        bp_new = Simulink.BlockPath({strrep(bp.getBlock(1), loop_real, loop_model), ...
                                    strrep(bp.getBlock(2), sc_real, sc_model)});
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
        C0 = predictcost(loop_model, states_cur, pred_horizon, g);
        disp(['Predicted C(0) = ' num2str(C0)])
        C0s = [C0s C0];

        for n=1:length(dgs)
            %C(g+dg)
            g_test = g + dgs_mat(:, n);
            C0 = predictcost(loop_model, states_cur, pred_horizon, g_test);
            disp(['Predicted C(' num2str(n) ') = ' num2str(Cs(n)) ' with g = ' num2str(g_test.')])
        end

        %evaluate gradC
        gradC = (Cs-C0*ones(6, 1))./dgs;
        gradC = gradC/norm(gradC);
        disp(['Predicted gradC = ' num2str(gradC.')])
        
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
    t_elapse = toc(t_start);
    disp('----------------------------------')
    disp(['Time Taken = ' num2str(t_elapse) 's'])
    disp(['Gradient Descent Finished at iteration #' num2str(i)])
    disp(['Final Control Gains = ' num2str(g.')])
    hold on
    plot(1:length(C0s), C0s);

    function cost = predictcost(loop_model, states_cur, pred_horizon, g_test)
        %add values of k and lambda to base workspace
        assignin('base', 'ks', g_test(1:3));
        assignin('base', 'lambdas', g_test(4:6));
        
        %add values of initial states to workspace
        assignin('base', 'states_cur', states_cur);

        %sim
        out_pred = sim(loop_model, ...
                       'StopTime', num2str(pred_horizon), ...
                       'LoadInitialState', 'on', 'InitialState', 'states_cur');

        %gather data
        [ts, es] = prepforcost(out_pred);

        %calculate cost
        cost = evaluatecost(ts, es) + 0.025*dot(g_test(1:3), g_test(1:3));
    end
end 