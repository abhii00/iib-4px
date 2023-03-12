%shortcut file to prepare and visualise, after simulation run
%requires filename, out, info, rt_taken to be defined

%make directories
mkdir(['./results/' filename '/']);
fn = ['./results/' filename '/' filename];

%prep data
prepinfo(info, fn);
[ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn);
[tgs, ks, lambdas] = prepgain(out, fn);

%visualise data
visualiseperf(qs_acc, qs_tar, ts, costfunction, rt_taken, fn);
visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn);