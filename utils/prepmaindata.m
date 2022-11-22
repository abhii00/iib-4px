function [ts, qs_acc, qds_acc, qdds_acc, qs_tar] = prepmaindata(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [ts, qs_acc, qds_acc, qdds_acc, qs_tar]: the time, actual state and target state arrays

    ts = out.tout;
    qs_acc = getdatasamples(out.q_acc, 1:length(ts));
    qds_acc = getdatasamples(out.qd_acc, 1:length(ts));
    qdds_acc = getdatasamples(out.qd_acc, 1:length(ts));
    qs_tar = getdatasamples(out.q_tar, 1:length(ts));

    save(['./data/', fn, '_main.mat'], 'ts', 'qs_acc', 'qds_acc', 'qdds_acc', 'qs_tar');

    csvo = [ts, permute(qs_acc, [3, 1, 2]), permute(qds_acc, [3, 1, 2]), permute(qdds_acc, [3, 1, 2]), permute(qs_tar, [3, 1, 2])];
    writematrix(csvo, ['./data/', fn, '_main.csv'])