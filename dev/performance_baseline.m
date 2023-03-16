clear

%open models
loop = 'cube0_pd';
loop2 = 'cubewithpanels0_pd';

open(loop);
set_param(loop, 'FastRestart', 'on');
open(loop2);
set_param(loop2, 'FastRestart', 'on');

%params
tar = 3;

%gains
k = [1 1 1];
lambda = [50 50 50];
k_ser = timeseries(k, 0);
lambda_ser = timeseries(lambda, 0);

%ERR
costfunction = 1;

%1_CUBE0_BASELINE_1
t_tot = 200;
aux = false;
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cube0_baseline_1';
info = '1: Step of pi/2 around yz. 200s. baseline: [1 1 1] [50 50 50]. 1: e^2.';
prepvisualise;
close all;

%1_CUBEWITHPANELS0_BASELINE_1
t_tot = 400;
aux = true;
rt_start = tic;
out = sim(loop2, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_baseline_1';
info = '1: Step of pi/2 around yz. 400s. baseline: [1 1 1] [50 50 50]. 1: e^2.';
prepvisualise;
close all;

%ERR + RWV
costfunction = 2;

%1_CUBE0_BASELINE_2
t_tot = 200;
aux = false;
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cube0_baseline_2';
info = '1: Step of pi/2 around yz. 200s. baseline: [1 1 1] [50 50 50]. 2: e^2 + 1e-6*ws_rw^2.';
prepvisualise;
close all;

%1_CUBEWITHPANELS0_BASELINE_2
t_tot = 400;
aux = true;
rt_start = tic;
out = sim(loop2, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_baseline_2';
info = '1: Step of pi/2 around yz. 400s. baseline: [1 1 1] [50 50 50]. 2: e^2 + 1e-6*ws_rw^2.';
prepvisualise;
close all;

%ERR + THETAS
costfunction = 3;
t_tot = 400;
aux = true;
rt_start = tic;
out = sim(loop2, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_baseline_3';
info = '1: Step of pi/2 around yz. 400s. baseline: [1 1 1] [50 50 50]. 2: e^2 + 500*thetas^2.';
prepvisualise;
close all;