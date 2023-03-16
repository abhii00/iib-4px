%CUBEWITHPANELS0
%open models
loop_real = 'cubewithpanels0_mpcpd';
loop_model = 'cube0_mpcpd_model';
sc_real = 'cubewithpanels0';
sc_model = 'cube0_model';

open(loop_real);
set_param(loop_real, 'FastRestart', 'on',  'SaveState', 'on', 'StateSaveName', 'states', 'MaxStep', '1');
open(loop_model);
set_param(loop_model, 'FastRestart', 'on');

%1_CUBEWITHPANELS0_CUBE0
%params
t_tot = 400;
tar = 3;
costfunction = 1;

%mpcpd params
pred_horizon = 50;
cont_update = 10;
g = [1; 1; 1; 50; 50; 50];
iterations = 5;
learning_rate = 0.2;

%sim
aux = false;
rt_start = tic;
set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
    pause(1)
end
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_cube0';
info = '50 10 [1 1 1 50 50 50] 5 0.2 EG (e^2 + 0.01k^2) with cube0 model';
aux = true;
prepvisualise;
close all;