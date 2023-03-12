function [tgs, ks, lambdas] = prepgain(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [tcs, ks, lambdas]: the control
%   time and the gains

    tgs = out.k.Time;
    ks = getdatasamples(out.k, 1:length(tgs));
    lambdas = getdatasamples(out.lambda, 1:length(tgs));

    save([fn, '_gain.mat'], 'tgs', 'ks', 'lambdas');

    csvo = [tgs, ks, lambdas];
    writematrix(csvo, [fn, '_gain.csv']);
end