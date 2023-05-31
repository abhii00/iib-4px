fn_rho = 'results/performance_cost/1_cube0_a/1_cube0_a_main.mat';
s_rho = load(fn_rho);
es_rho = err(s_rho.ts, s_rho.qs_acc, s_rho.qs_tar);

%PLOT
figure;
plot(s_rho.ts, es_rho, 'Color', [1, 0, 1]);
xlabel('t (s)');
ylabel('\delta\theta');

function es = err(ts, qs_acc, qs_tar)
    es = zeros(length(ts), 1);
    for i = 1:length(ts)
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');
        es(i) = dist(qm_acc, qm_tar);
    end
end
