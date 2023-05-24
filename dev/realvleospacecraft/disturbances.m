%no disturbance
no_tau_dist = [0 0 0];
no_tau_dist_ser = timeseries(no_tau_dist, 0);

%light disturbance
light_tau_dist = [5e-3 5e-3 0];
light_tau_dist_ser = timeseries(light_tau_dist, 0);

%heavy disturbance
heavy_tau_dist = [5e-2 5e-2 0];
heavy_tau_dist_ser = timeseries(heavy_tau_dist, 0);

%light varying disturbance
lightvary_tau_dist_ser = timeseries([light_tau_dist; -light_tau_dist], [0 100]);

%heavy varying disturbance
heavyvary_tau_dist_ser = timeseries([heavy_tau_dist; -heavy_tau_dist], [0 100]);