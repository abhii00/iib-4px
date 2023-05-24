%shortcut file to prepare and visualise, after simulation run
%requires filename, out, info, rt_taken to be defined

%make directories
mkdir(['./results/' filename '/']);
fn = ['./results/' filename '/' filename];

%prep data
prepinfo(info, fn);
[ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn);
[tgs, ks, lambdas] = prepgain(out, fn);
[ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls] = prepaux(out, fn);
thetas = [thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b];

%visualise data
visualiseperf(qs_acc, qs_tar, ws_rw, thetas, taus, ts, costfunction, rt_taken, fn);
visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn);
visualiseaux(thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls, ts, fn);