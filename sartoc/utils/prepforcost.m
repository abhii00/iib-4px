function [ts, es] = prepforcost(out)
%preps data for the cost function
%
%Arguments:
%   out (Simulink.SimulationOutput): simulation out
%
%Returns:
%   ts (list(float)): list of times
%   es (list(float)): list of errors

    %get out data
    ts = out.tout;
    qs_acc = getdatasamples(out.q_acc, 1:length(ts));
    qs_tar = getdatasamples(out.q_tar, 1:length(ts));

    %calculate error
    es = zeros(size(ts));
    for j = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, j), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, j), 'simulink', 'matlab');

        es(j) = dist(qm_tar, qm_acc);
    end
end