function g = mpcpd(costfunction)
    %INIT
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

    %INITIAL STATE FOR PREDICTION
    %extract states from current sim by forcing log write
    set_param(loop_real, 'SimulationCommand', 'WriteDataLogs');
    out_real = evalin('base', 'out');
    states_real = out_real.states;
    clearvars out_real;
    
    %extract states from model by forcing log write
    assignin('base', 'k', g(1:3));
    assignin('base', 'lambda', g(4:6));
    out_model = sim(loop_model, 'StopTime', num2str(1));
    states_model = out_model.states;
    clearvars out_model;

    %modify initial states
    states_to_remove_for_model = [];
    states_for_model = states_real;
    for i=1:numElements(states_real)
        %change blockpath from sc_real, loop_real to sc_model,
        %loop_model
        bp_real = states_real{i}.BlockPath;
        bp_length = getLength(bp_real);
        if (bp_length==1) %case for non-sc-model paths (in loop)
            bp_for_model = Simulink.BlockPath({strrep(bp_real.getBlock(1), loop_real, loop_model)});
        elseif (bp_length==2) %case for sc-model paths
            bp_for_model = Simulink.BlockPath({strrep(bp_real.getBlock(1), loop_real, loop_model), ...
                                        strrep(bp_real.getBlock(2), sc_real, sc_model)});
        end

        %check if real state exists in model states
        is_real_in_model = [];
        for j = 1:numElements(states_model)
            is_real_in_model = [is_real_in_model isequal(states_model{j}.BlockPath, bp_for_model)];
        end

        %if real state in model states
        if any(is_real_in_model)
            %change name from sc_real to sc_model
            nm_real = states_real{i}.Name;
            nm_for_model = strrep(nm_real, sc_real, sc_model);

            %change to last value
            val_for_model = getsamples(states_real{i}.Values, length(states_real{i}.Values.Time));
            
            %update
            states_for_model{i}.Name = nm_for_model;
            states_for_model{i}.Values = val_for_model;
            states_for_model{i}.BlockPath = bp_for_model;
        else
            states_to_remove_for_model = [states_to_remove_for_model i];
        end
    end
    states_for_model = removeElement(states_for_model, states_to_remove_for_model);
    clearvars states_to_remove_for_model states_real states_model;

    %OPTIMISE
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
        C0 = predictcost(loop_model, states_for_model, pred_horizon, costfunction, g);
        disp(['Predicted C(0) = ' num2str(C0)])
        if (i == 1)
            C0_0 = C0;
        end

        parfor n=1:length(dgs)
            %C(g+dg)
            g_test = g + dgs_mat(:, n);
            Cs(n) = predictcost(loop_model, states_for_model, pred_horizon, costfunction, g_test);
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