function [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b] = prepaux(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b]: the time, and the four solar
%   panel rotation arrays

    ts = out.tout;
    thetas_sp1a = getdatasamples(out.theta_sp1a, 1:length(ts));
    thetas_sp1b = getdatasamples(out.theta_sp1b, 1:length(ts));
    thetas_sp2a = getdatasamples(out.theta_sp2a, 1:length(ts));
    thetas_sp2b = getdatasamples(out.theta_sp2b, 1:length(ts));

    thetas_sp1a = permute(thetas_sp1a, [3, 1, 2]);
    thetas_sp1b = permute(thetas_sp1b, [3, 1, 2]);
    thetas_sp2a = permute(thetas_sp2a, [3, 1, 2]);
    thetas_sp2b = permute(thetas_sp2b, [3, 1, 2]);

    save([fn, '_aux.mat'], 'ts', 'thetas_sp1a', 'thetas_sp1b', 'thetas_sp2a', 'thetas_sp2b');

    csvo = [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b];
    writematrix(csvo, [fn, '_aux.csv']);
end