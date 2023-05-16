%simulate
sim_complete = false;
rt_start = tic;
set_param(loop_real, 'SimulationCommand', 'start', 'StopTime', num2str(t_tot));
while ~(sim_complete)
    pause(0.01)
end
rt_taken = toc(rt_start);