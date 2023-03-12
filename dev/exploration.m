%open models
loop_real = 'cube0_mpcpd';
loop_model = 'cube0_mpcpd_model';
sc_real = 'cube0';
sc_model = 'cube0_model';

open(loop_real);
set_param(loop_real,'FastRestart', 'on',  'SaveState', 'on', 'StateSaveName', 'states');
open(loop_model);
set_param(loop_model,'FastRestart','on');

%TEST 1a---------------

%params
tar = 3;
costfunction = 1;
t_tot = 400;

%mpcpd params
pred_horizon = 50;
cont_update = 10;
g = [1; 1; 1; 50; 50; 50];
iterations = 20;
learning_rate = 0.1;

%sim
rt_start = tic;
set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
    pause(1)
end
rt_taken = toc(rt_start);
filename = '1_a';
info = '50 10 [1 1 1 50 50 50] 20 0.1 (e^2 + 0.025k^2)';
prepvisualise;