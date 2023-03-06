function g = mpcpd(t)
    persistent t_seq g_seq update_no

    %simulation parameters
    model_name = 'cube0_mpcpdmodel';
    
    %horizons
    pred_horizon = 15;
    cont_horizon = 10;
    
    %learning parameters
    g_next_0 = [1; 1; 1; 50; 50; 50];
    dg = 0.05*ones(6, 1);
    iterations = 100;
    eta = 0.05;
    
    %setup empty time and control sequences
    update_req = false;
    if (isempty(t_seq))
        t_seq = [];
        g_seq = [];
        update_no = 0;
        update_req = true;
        disp('============')
        disp('Starting MPC')
        disp('============')
    elseif (t - t_seq(end) >= cont_horizon)
        update_req = true;
    end

    %update if needed
    if (update_req)
        disp('==================================')
        disp(['Updating for t = ' num2str(t) 's'])

        %extend time sequence
        t_seq(end+1) = t;

        %copy and extend actual control sequence for gradient descent
        test_g_seq = g_seq;
        test_g_seq(:, end+1) = zeros(6, 1);
        
        %initialise guess and cost
        g_next = g_next_0;
        C0s = [];
        
        %perform gradient descent
        gradient_descent = true;
        i = 1;
        t_start = tic;
        while (gradient_descent)
            disp('----------------------------------')
            disp(['Trying Control Gains = ' num2str(g_next.') ' for iteration #' num2str(i)])

            %extend dg into matrix, and set up dg
            dgs = diag(dg);
            Cs = zeros(6, 1);
            gradC = ones(6, 1);

            %C(k, lambda)
            test_g_seq(:, end) = g_next;
            output = simulate(model_name, t, pred_horizon, test_g_seq, t_seq);
            C0 = evaluateC(output, g_next);
            disp('Evaluated C(0)')
            C0s = [C0s C0];
    
            for n=1:length(dg)
                %C(k + some dk, lambda + some dk) 
                test_g_seq(:, end) = g_next + dgs(:, n);
                output = simulate(model_name, t, pred_horizon, test_g_seq, t_seq);
                Cs(n) = evaluateC(output, g_next + dgs(:, n));
                disp(['Evaluated C(' num2str(n) ')'])
                if Cs(n) < 0
                    Cs(n) = 0;
                end
            end

            %evaluate gradC
            gradC = (Cs-C0*ones(6, 1))./dg;
            gradC = gradC/norm(gradC);
            disp(['Evaluated gradC = ' num2str(gradC.')])
            
            %step down gradient and check for completion
            g_next = g_next - eta*gradC;
            i = i + 1;
            if (all(gradC == 0) || (i > iterations))
                gradient_descent = false;
                disp('----------------------------------')
                disp(['Gradient Descent Finished at iteration #' num2str(i)])
            end
        end

        %end gradient descent
        disp(['Time Taken = ' num2str(toc(t_start)) 's'])
        hold on
        plot(C0s);

        %extend actual control sequence
        g_seq(:, end+1) = g_next;
        update_no = update_no + 1;
        disp(['Final Control Gains = ' num2str(g_seq(:, end).') ' for t = ' num2str(t) 's'])
    end

    %assign control
    g = g_seq(:, end);

    function output = simulate(mdl_name, t1, pred_horizon, g_seq, t_seq)
        %construct individual time series for k, lambda
        ks_series = timeseries(g_seq(1:3, :), t_seq);
        lambdas_series = timeseries(g_seq(4:6, :), t_seq);
        
        %add time series to base workspace for access by simulink
        assignin('base','ks_series', ks_series);
        assignin('base','lambdas_series', lambdas_series);
        
        %simulate
        output = sim(mdl_name, 'StopTime', num2str(t1+pred_horizon));
    end

    function C = evaluateC(output, g_next)
        %get output data and trim to only after current time
        ts = output.tout;
        qs_acc = getdatasamples(output.q_acc, 1:length(ts));
        qs_tar = getdatasamples(output.q_tar, 1:length(ts));
        qs_acc = qs_acc(:, :, ts > t);
        qs_tar = qs_tar(:, :, ts > t);
        ts = ts(ts > t);

        es = zeros(size(ts));

        for j = 1:length(ts)
            qm_acc = quatconvert(qs_acc(:, :, j), 'simulink', 'matlab');
            qm_tar = quatconvert(qs_tar(:, :, j), 'simulink', 'matlab');
            es(j) = dist(qm_tar, qm_acc);
        end

        %calculate cost
        cost = cumtrapz(ts, es.^2);
        C = cost(end);

        %penalise negative
        if any(g_next <= 0)
            C = C*10;
        end
    end
end 