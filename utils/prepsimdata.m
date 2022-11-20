function [ts, qs_acc, qs_tar] = prepsimdata(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%
%Returns:
%   [ts, qs_acc, qs_tar]: the time, actual state and target state arrays
    ts = out.tout;
    qs_acc = getdatasamples(out.q_acc, 1:length(ts));
    qs_tar = getdatasamples(out.q_tar, 1:length(ts));
    save(['./data/', fn, '.mat'], 'ts', 'qs_acc', 'qs_tar');

    csvo = [ts, permute(qs_acc, [3, 1, 2]), permute(qs_tar, [3, 1, 2])];
    writematrix(csvo, ['./data/', fn, '.csv'])