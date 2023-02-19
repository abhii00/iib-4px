%simulation parameters
t_tot = 20;
model_name = 'pen_mpcpd_offline';

%horizons
pred_horizon = 5;
cont_horizon = 2;

%learning parameters
u_next_0 = [1; 1];
du = [0.05; 0.05];
iterations = 10;
eta = 0.05;

%setup empty time and control sequences
t_seq = [];
u_seq = [;];

%simulate across entire simulation
for t = 0:cont_horizon:t_tot
    
    %extend time sequence
    t_seq(end+1) = t;

    %copy and extend actual control sequence for gradient descent
    test_seq = u_seq;
    test_seq(:, end+1) = zeros(2, 1);

    %initialise guess and cost
    u_next = u_next_0;
    cost_seq = zeros(1, iterations);

    %perform gradient descent
    for i = 1:iterations
        disp(['Iteration ' num2str(i) ' for t = ' num2str(t)])

        %C(k, lambda)
        test_seq(:, end) = u_next;
        C0 = evaluateC(model_name, test_seq, t_seq, t, pred_horizon);
        cost_seq(i) = C0;

        %C(k+dk, lambda)
        test_seq(:, end) = u_next + [du(1); 0];
        Ck = evaluateC(model_name, test_seq, t_seq, t, pred_horizon);

        %C(k, lambda+dlambda)
        test_seq(:, end) = u_next + [0; du(2)];
        Clambda = evaluateC(model_name, test_seq, t_seq, t, pred_horizon);

        %evaluate gradC
        gradC = [(Ck - C0); (Clambda-C0)]./du;
        
        %step down gradient
        u_next = u_next - eta*gradC;
    end

    %plot costs for gradient descent
    scatter(1:iterations, cost_seq)
    xlabel('Iteration No.')
    ylabel('Cost')
    drawnow()

    %extend actual control sequence
    u_seq(:, end+1) = u_next;
end

t_seq
u_seq
evaluateC(model_name, u_seq, t_seq, t_tot, pred_horizon);
save([model_name '_' 'pdrhc'], 'k_series', 'lambda_series');

function C = evaluateC(mdl_name, u_u_seq, u_t_seq, t_cur, t_extra)
    %construct individual time series for k, lambda
    k_series = timeseries(u_u_seq(1, :), u_t_seq);
    lambda_series = timeseries(u_u_seq(2, :), u_t_seq);

    %add time series to base workspace for access by simulink
    assignin('base','k_series', k_series);
    assignin('base','lambda_series', lambda_series);

    %simulate
    disp('Sim Started')
    out = sim(mdl_name, t_cur+t_extra);
    disp('Sim Complete')

    %get output data and trim to only after current time
    ts = out.tout;
    es = getdatasamples(out.es, 1:length(ts));
    ys = getdatasamples(out.ys, 1:length(ts));
    ts = ts(ts > t_cur);
    es = es(ts > t_cur);
    ys = ys(ts > t_cur);
    
    %calculate cost
    cost = cumtrapz(ts, es.^2 + ys.^2);
    C = cost(end);
end