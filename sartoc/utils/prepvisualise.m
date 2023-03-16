%shortcut file to prepare and visualise, after simulation run
%requires filename, out, info, rt_taken to be defined

%make directories
mkdir(['./results/' filename '/']);
fn = ['./results/' filename '/' filename];

%prep data
prepinfo(info, fn);
[ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn);
[tgs, ks, lambdas] = prepgain(out, fn);
thetas = zeros(size(ts));
if (exist('aux','var') == 1)
    if aux
        [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b] = prepaux(out, fn);
        thetas = [thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b];
    end
end

%visualise data
visualiseperf(qs_acc, qs_tar, ws_rw, thetas, ts, costfunction, rt_taken, fn);
visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn);
if (exist('aux','var') == 1)
    if aux
        visualiseaux(thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, ts, fn);
    end
end