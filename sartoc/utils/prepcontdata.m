function [tcs, ks, lambdas] = prepcontdata(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [cs, ks, lambdas]: the control
%   time and the gains

    tcs = out.kss.Time;
    ks = getdatasamples(out.kss, 1:length(tcs));
    lambdas = getdatasamples(out.css, 1:length(tcs));

    save(['./results/', fn, '_cont.mat'], 'tcs', 'ks', 'lambdas');

    csvo = [tcs, ks, lambdas];
    writematrix(csvo, ['./results/', fn, '_cont.csv']);
end