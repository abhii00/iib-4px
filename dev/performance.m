% clear;
% 
% %CUBE0=========================
% %open models
% loop_real = 'cube0_mpcpd';
% loop_model = 'cube0_mpcpd_model';
% sc_real = 'cube0';
% sc_model = 'cube0_model';
% 
% open(loop_real);
% set_param(loop_real, 'FastRestart', 'on',  'SaveState', 'on', 'StateSaveName', 'states', 'MaxStep', '1');
% open(loop_model);
% set_param(loop_model, 'FastRestart', 'on');
% 
% aux = false;
% t_tot = 200;
% 
% %1_CUBE0_B------------------------
% loop_real = 'cube0_mpcpd';
% loop_model = 'cube0_mpcpd_model';
% sc_real = 'cube0';
% sc_model = 'cube0_model';
% aux = false;
% t_tot = 200;
% 
% %params
% tar = 3;
% costfunction = 1;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 25;
% learning_rate = 0.1;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cube0_b';
% info = 'b: 50 10 [1 1 1 50 50 50] 25 0.1 EG (e^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;
% 
% %1_CUBE0_C------------------------
% loop_real = 'cube0_mpcpd';
% loop_model = 'cube0_mpcpd_model';
% sc_real = 'cube0';
% sc_model = 'cube0_model';
% aux = false;
% t_tot = 200;
% 
% %params
% tar = 3;
% costfunction = 2;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 25;
% learning_rate = 0.1;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cube0_c';
% info = 'c: 50 10 [1 1 1 50 50 50] 25 0.1 EG (e^2 + 1e-6w_rw^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;
% 
% %1_CUBE0_D------------------------
% loop_real = 'cube0_mpcpd';
% loop_model = 'cube0_mpcpd_model';
% sc_real = 'cube0';
% sc_model = 'cube0_model';
% aux = false;
% t_tot = 200;
% 
% %params
% tar = 3;
% costfunction = 1;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 5;
% learning_rate = 0.5;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cube0_d';
% info = 'd: 50 10 [1 1 1 50 50 50] 5 0.2 EG (e^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;
% 
% CUBEWITHPANELS0=========================
% open models
% loop_real = 'cubewithpanels0_mpcpd';
% loop_model = 'cubewithpanels0_mpcpd_model';
% sc_real = 'cubewithpanels0';
% sc_model = 'cubewithpanels0_model';
% 
% open(loop_real);
% set_param(loop_real, 'FastRestart', 'on',  'SaveState', 'on', 'StateSaveName', 'states', 'MaxStep', '1');
% open(loop_model);
% set_param(loop_model, 'FastRestart', 'on');
% 
% aux = true;
% t_tot = 400;
% 
% %1_CUBEWITHPANELS0_B------------------------
% loop_real = 'cubewithpanels0_mpcpd';
% loop_model = 'cubewithpanels0_mpcpd_model';
% sc_real = 'cubewithpanels0';
% sc_model = 'cubewithpanels0_model';
% aux = true;
% t_tot = 400;
% 
% %params
% tar = 3;
% costfunction = 1;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 25;
% learning_rate = 0.1;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cubewithpanels0_b';
% info = 'b: 50 10 [1 1 1 50 50 50] 25 0.1 EG (e^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;
% 
% %1_CUBEWITHPANELS0_C------------------------
% loop_real = 'cubewithpanels0_mpcpd';
% loop_model = 'cubewithpanels0_mpcpd_model';
% sc_real = 'cubewithpanels0';
% sc_model = 'cubewithpanels0_model';
% aux = true;
% t_tot = 400;
% 
% %params
% tar = 3;
% costfunction = 2;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 25;
% learning_rate = 0.1;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cubewithpanels0_c';
% info = 'c: 50 10 [1 1 1 50 50 50] 25 0.1 EG (e^2 + 1e-6w_rw^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;

%1_CUBEWITHPANELS0_D------------------------
loop_real = 'cubewithpanels0_mpcpd';
loop_model = 'cubewithpanels0_mpcpd_model';
sc_real = 'cubewithpanels0';
sc_model = 'cubewithpanels0_model';
aux = true;
t_tot = 400;

%params
tar = 3;
costfunction = 1;

%mpcpd params
pred_horizon = 50;
cont_update = 10;
g = [1; 1; 1; 50; 50; 50];
iterations = 5;
learning_rate = 0.2;

%sim
rt_start = tic;
set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
    pause(1)
end
rt_taken = toc(rt_start);
filename = '1_cubewithpanels0_d';
info = 'd: 50 10 [1 1 1 50 50 50] 5 0.2 EG (e^2 + 0.01k^2)';
prepvisualise;
close all;
clear;

% %1_CUBEWITHPANELS0_E------------------------
% loop_real = 'cubewithpanels0_mpcpd';
% loop_model = 'cubewithpanels0_mpcpd_model';
% sc_real = 'cubewithpanels0';
% sc_model = 'cubewithpanels0_model';
% aux = true;
% t_tot = 400;
% 
% %params
% tar = 3;
% costfunction = 3;
% 
% %mpcpd params
% pred_horizon = 50;
% cont_update = 10;
% g = [1; 1; 1; 50; 50; 50];
% iterations = 25;
% learning_rate = 0.1;
% 
% %sim
% rt_start = tic;
% set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
% while strcmp(get_param(loop_real, 'SimulationStatus'), 'running')
%     pause(1)
% end
% rt_taken = toc(rt_start);
% filename = '1_cubewithpanels0_e';
% info = 'e: 50 10 [1 1 1 50 50 50] 25 0.1 EG (e^2 + 500theta^2 + 0.01k^2)';
% prepvisualise;
% close all;
% clear;