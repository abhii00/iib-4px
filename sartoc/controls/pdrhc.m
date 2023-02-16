chor = 2; %control horizon
phor = 5; %prediction horizon

t_seq = [0];
k_seq = [1];
lambda_seq = [1];

dk = 0.05;
dlambda = 0.05;

%update every control step
for t = 0:chor:20

    %setup sequences
    t_seq(end+1) = t;
    k_guess = 1;
    lambda_guess = 1;
    k_seq(end+1) = k_guess;
    lambda_seq(end+1) = lambda_guess;

    disp(t)
    %optimise k, lambda over horizon
    for i = 1:150
        %try 4 variations
        costs = zeros(2, 2);
        ks_trial = [k_guess + dk, k_guess, k_guess - dk];
        lambdas_trial = [lambda_guess + dlambda, lambda_guess, lambda_guess - dlambda];

        disp(i)
        for j = 1:3
            for m = 1:3
                %setup k, lambda
                k_seq(end) = ks_trial(j);
                lambda_seq(end) = lambdas_trial(m);

                k_series = timeseries(k_seq, t_seq);
                lambda_series = timeseries(lambda_seq, t_seq);

                %evaluate model
                disp('Sim Started')
                out = sim('pen_mpcpd_train', t+phor);
                disp('Sim Complete')

                ts = out.tout;
                es = getdatasamples(out.es, 1:length(ts));
                ys = getdatasamples(out.ys, 1:length(ts));

                %calculate cost
                cost = cumtrapz(ts, es.^2 + ys.^2);
                costs(j, m) = cost(end);
            end
        end

        %find k, lambda that give minimum cost
        costs
        [min_j, min_m] = find(costs==min(costs(:)));
        k_guess = ks_trial(min_j)
        lambda_guess = lambdas_trial(min_m)
    end

    %store
    k_seq(end) = k_guess;
    lambda_seq(end) = lambda_guess;
end

%final values
k_series = timeseries(k_seq, t_seq);
lambda_series = timeseries(lambda_seq, t_seq);