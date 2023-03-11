clear

%params
loop_real = 'cube0_mpcpd';
loop_model = 'cube0_mpcpd_model';
sc_real = 'cube0';
sc_model = 'cube0_model';
pred_horizon = 50;
cont_update = 10;

%open
open(loop_real);
set_param(loop_real,'FastRestart','on');
set_param(loop_real, 'SaveState', 'on', 'StateSaveName', 'states')
open(loop_model);
set_param(loop_model,'FastRestart','on');

%test
sim(loop_real, 'StopTime', num2str(400));
prepvis(out, 'test');

function prepvis(out, filename)
    mkdir(['./results/' filename '/']);
    fn = ['./results/' filename '/' filename];
    prepinfo(fn);
    [ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn);
    [tgs, ks, lambdas] = prepgain(out, fn);
    visualiseerr(qs_acc, qs_tar, ts, fn, p);
    visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn);
end