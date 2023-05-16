%simulate
rt_start = tic;
out = sim(loop, 'StopTime', num2str(t_tot));
rt_taken = toc(rt_start);