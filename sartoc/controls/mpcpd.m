function g = mpcpd(costfunction)
    %mpc-pd parameters
    loop_real = evalin('base', 'loop_real');
    loop_model = evalin('base', 'loop_model');
    sc_real = evalin('base', 'sc_real');
    sc_model = evalin('base', 'sc_model');
    pred_horizon = evalin('base', 'pred_horizon');
    
    %learning parameters
    g = evalin('base', 'g');
    iterations = evalin('base', 'iterations');
    learning_rate = evalin('base', 'learning_rate');

    %extract states from current sim and state structure from model sim
    set_param(loop_real, 'SimulationCommand', 'WriteDataLogs');
    out_cur = evalin('base', 'out');
    states_cur = out_cur.states;
    assignin('base', 'k', g(1:3));
    assignin('base', 'lambda', g(4:6));
    states_needed = Simulink.BlockDiagram.getInitialState(loop_model);
    states_to_remove = [];

    %modify initial state labels
    for i = 1:numElements(states_cur)
        %replace name from sc_real -> sc_model
        nm = states_cur{i}.Name;
        nm_new = strrep(nm, sc_real, sc_model);

        %check if state exists in needed states
        check_in_states_needed = [];
        for j = 1:numElements(states_needed)
            check_in_states_needed = [check_in_states_needed contains(states_needed{j}.Name, nm_new)];
        end

        if any(check_in_states_needed)
            %get last value
            val_new = getsamples(states_cur{i}.Values, length(states_cur{i}.Values.Time));
    
            %fix blockpath
            bp = states_cur{i}.BlockPath;
            bp_new = Simulink.BlockPath({strrep(bp.getBlock(1), loop_real, loop_model), ...
                                        strrep(bp.getBlock(2), sc_real, sc_model)});
    
            %set new state labels
            states_cur{i}.Name = nm_new;
            states_cur{i}.Values = val_new;
            states_cur{i}.BlockPath = bp_new;
        else
            states_to_remove = [states_to_remove i];
        end
    end

    states_cur = removeElement(states_cur, states_to_remove)

    %perform gradient descent
    disp('==================================')
    rt_start = tic;
    C0_0 = 0;
    C0_end = 0;
    dgs = 0.05*ones(6, 1);
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
        C0 = predictcost(loop_model, states_cur, pred_horizon, costfunction, g);
        disp(['Predicted C(0) = ' num2str(C0)])
        if (i == 1)
            C0_0 = C0;
        end

        parfor n=1:length(dgs)
            %C(g+dg)
            g_test = g + dgs_mat(:, n);
            Cs(n) = predictcost(loop_model, states_cur, pred_horizon, costfunction, g_test);
            disp(['Predicted C(' num2str(n) ') = ' num2str(Cs(n)) ' with g = ' num2str(g_test.')])
        end

        %evaluate gradC
        gradC = (Cs-C0*ones(6, 1))./dgs;
        gradC = gradC/norm(gradC);
        disp(['Predicted gradC = ' num2str(gradC.')])
        
        %step down gradient
        g = g.*exp(-learning_rate*gradC);

        %check for completion
        i = i + 1;
        if (all(gradC == 0) || (i >= iterations))
            gradient_descent = false;
            C0_end = C0;
        end
    end

    %end gradient descent
    disp('----------------------------------')
    disp(['Gradient Descent Finished at iteration #' num2str(i)])
    disp(['Final Control Gains = ' num2str(g.')])
    disp(['Decrease in Cost = ' num2str(C0_0 - C0_end)])
    disp(['Real Time Taken = ' num2str(toc(rt_start)) 's'])
end 