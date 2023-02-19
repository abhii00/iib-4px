function g = mpcpd(t)
    persistent t_seq g_seq

    %simulation parameters
    model_name = 'cube0_mpcpdmodel_ref_ls';
    
    %horizons
    pred_horizon = 5;
    cont_horizon = 2;
    
    %learning parameters
    g_next_0 = [1; 1; 1; 1; 1; 1];
    dg = [0.05; 0.05; 0.05; 0.05; 0.05; 0.05];
    iterations = 100;
    eta = 0.05;
    
    %setup empty time and control sequences
    if (t == 0)
        t_seq = [];
        g_seq = [];
    end
   
    %update if needed
    if ((t == 0) || (t - t_seq(end) >= cont_horizon))
        disp('==================================')
        disp(['Updating for t = ' num2str(t) 's'])

        %extend time sequence
        t_seq(end+1) = t;

        %copy and extend actual control sequence for gradient descent
        test_g_seq = g_seq;
        test_g_seq(:, end+1) = zeros(2, 1);
        
        %initialise guess and cost
        g_next = g_next_0;
        
        %perform gradient descent
        gradient_descent = true;
        i = 1;
        while (gradient_descent)
            disp('----------------------------------')
            disp(['Trying Control Gains = ' num2str(g_next.') ' for iteration #' num2str(i)])

            %C(k, lambda)
            test_g_seq(:, end) = g_next;
            out = simulate(model_name, t, pred_horizon, test_g_seq, t_seq);
            C0 = evaluateC(out);
            disp(['Evaluated C(k, lambda) = ' num2str(C0)]);
    
            %C(k+dk, lambda)
            test_g_seq(:, end) = g_next + [dg(1); 0];
            out = simulate(model_name, t, pred_horizon, test_g_seq, t_seq);
            Ck = evaluateC(out);
            disp(['Evaluated C(k+dk, lambda) = ' num2str(Ck)]);
    
            %C(k, lambda+dlambda)
            test_g_seq(:, end) = g_next + [0; dg(2)];
            out = simulate(model_name, t, pred_horizon, test_g_seq, t_seq);
            Clambda = evaluateC(out);
            disp(['Evaluated C(k, lambda+dlambda) = ' num2str(Clambda)]);
        
            %evaluate gradC
            gradC = [(Ck - C0); (Clambda-C0)]./dg;
            disp(['Evaluated gradC = ' num2str(gradC.')])
            
            %step down gradient and check for completion
            g_next = g_next - eta*gradC;
            i = i + 1;
            if (all(gradC == 0) || (i > iterations))
                gradient_descent = false;
            end
        end

        %extend actual control sequence
        g_seq(:, end+1) = g_next;
        disp('----------------------------------')
        disp(['Final Control Gains = ' num2str(g_seq(:, end).') ' for t = ' num2str(t) 's'])
    end

    %assign control
    g = g_seq(:, end);

    function out = simulate(mdl_name, t, pred_horizon, g_seq, t_seq)
        %construct individual time series for k, lambda
        ks_series = timeseries(g_seq(1:3, :), t_seq);
        lambdas_series = timeseries(g_seq(4:6, :), t_seq);
        
        %add time series to base workspace for access by simulink
        assignin('base','ks_series', ks_series);
        assignin('base','lambdas_series', lambdas_series);
        
        %simulate
        out = sim(mdl_name, t+pred_horizon);
    end

    function C = evaluateC(out)
        %get output data and trim to only after current time
        ts = out.tout;
        qs_acc = getdatasamples(out.q_acc, 1:length(ts));
        qs_tar = getdatasamples(out.q_tar, 1:length(ts));
        qs_acc = qs_acc(ts > t);
        qs_tar = qs_tar(ts > t);
        ts = ts(ts > t);

        es = zeros(size(ts));

        for j = 1:length(ts)
            qm_acc = quatconvert(qs_acc(j), 'simulink', 'matlab');
            qm_tar = quatconvert(qs_tar(j), 'simulink', 'matlab');
            es = dist(qm_tar, qm_acc);
        end

        %calculate cost
        cost = cumtrapz(ts, es.^2);
        C = cost(end);
    end
end 