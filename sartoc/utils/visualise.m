%shortcut file to visualise, after prep run

%create filename string
clear
filename = input('File Name:', 's');
fn = ['./results/' filename '/' filename];

%load relevant data files
load([fn '_main.mat'])
load([fn '_gain.mat'])
if exist('aux','var') == 1
    if aux
        load([fn '_aux.mat'])
    end
end

%visualise error
visualiseperf(qs_acc, qs_tar, ts, costfunction, rt_taken, fn);

%visualise control
visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn);

%visualise auxilary
if exist('aux','var') == 1
    if aux
        visualiseaux(thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_2p2b, ts, fn);
    end
end

%visualise trajectory
p = [1, 0, 0];
visualisetraj(qs_acc, qs_tar, ts, p);