function [ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus: the time, actual
%   state and target state arrays, as well as the reaction wheel speeds and
%   the distributed control torque magnitudes

    ts = out.tout;
    qs_acc = getdatasamples(out.q_acc, 1:length(ts));
    dqs_acc = getdatasamples(out.dq_acc, 1:length(ts));
    ddqs_acc = getdatasamples(out.ddq_acc, 1:length(ts));
    qs_tar = getdatasamples(out.q_tar, 1:length(ts));
    ws_rw = getdatasamples(out.w_rw, 1:length(ts));
    taus = getdatasamples(out.tau, 1:length(ts));

    save([fn '_main.mat'], 'ts', 'qs_acc', 'dqs_acc', 'ddqs_acc', 'qs_tar', 'ws_rw', 'taus');

    csvo = [ts, permute(qs_acc, [3, 1, 2]), permute(dqs_acc, [3, 1, 2]), permute(ddqs_acc, [3, 1, 2]), permute(qs_tar, [3, 1, 2]), ws_rw, taus];
    writematrix(csvo, [fn, '_main.csv']);
end