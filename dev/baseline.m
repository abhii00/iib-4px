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
costfunction = 1;

%gains
k = [1 1 1];
lambda = [50 50 50];
k_ser = timeseries(k, 0);
lambda_ser = timeseries(lambda, 0);

%2000
t_tot = 2000;

%1_CUBE0_BASELINE_2000
aux = false;
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cube0_baseline_2000';
info = '1: Step of pi/2 around yz. 2000s. baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;
close all;

%1_CUBEWITHPANELS0_BASELINE_2000
aux = true;
rt_start = tic;
out = sim(loop2, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_baseline_2000';
info = '1: Step of pi/2 around yz. 2000s. baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;
close all;

%400
t_tot = 400;

%1_CUBE0_BASELINE_400
aux = false;
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cube0_baseline_400';
info = '1: Step of pi/2 around yz. 400s. baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;
close all;

%1_CUBEWITHPANELS0_BASELINE_400
aux = true;
rt_start = tic;
out = sim(loop2, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_baseline_400';
info = '1: Step of pi/2 around yz. 400s. baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;
close all;

%200
t_tot = 200;

%1_CUBE0_BASELINE_200
aux = false;
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);
filename = '1_cube0_baseline_200';
info = '1: Step of pi/2 around yz. 200s. baseline: [1 1 1] [50 50 50] e^2.';
prepvisualise;
close all;