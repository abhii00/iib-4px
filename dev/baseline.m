clear

%open models
loop = 'cube0_pd';
open(loop);

%params
tar = 3;
costfunction = 1;
t_tot = 400;

%gains
k = [1 1 1];
lambda = [50 50 50];
k_ser = timeseries(ks, 0);
lambda_ser = timeseries(lambdas, 0);

%sim
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_baseline';
info = '1: Step of pi/2 around yz running for 400s. Baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;