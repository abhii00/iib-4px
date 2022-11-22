function [ts, qs_sp1a, qs_sp1b, qs_sp2a, qs_sp2b] = prepauxdata(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [ts, qs_sp1a, qs_sp1b, qs_sp2a, qs_sp2b]: the time, and the four solar
%   panel rotation arrays

    ts = out.tout;
    qs_sp1a = getdatasamples(out.q_sp1a, 1:length(ts));
    qs_sp1b = getdatasamples(out.q_sp1b, 1:length(ts));
    qs_sp2a = getdatasamples(out.q_sp2a, 1:length(ts));
    qs_sp2b = getdatasamples(out.q_sp2b, 1:length(ts));

    save(['./data/', fn, '_aux.mat'], 'ts', 'qs_sp1a', 'qs_sp1b', 'qs_sp2a', 'qs_sp2b');

    csvo = [ts, permute(qs_sp1a, [3, 1, 2]), permute(qs_sp1b, [3, 1, 2]), permute(qs_sp2a, [3, 1, 2]), permute(qs_sp2b, [3, 1, 2])];
    writematrix(csvo, ['./data/', fn, '_aux.csv'])