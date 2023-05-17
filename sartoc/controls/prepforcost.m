function [ts, es, ws_rw, thetas] = prepforcost(out)
%preps data for the cost function
%
%Arguments:
%   out (Simulink.SimulationOutput): simulation out
%
%Returns:
%   ts (list(float)): list of times
%   es (list(float)): list of errors
%   ws_rw (array(float)): array of reaction wheel velocities
%   thetas (array(float)): array of solar panel angles

    %get out data
    ts = out.tout;
    qs_acc = getdatasamples(out.q_acc, 1:length(ts));
    qs_tar = getdatasamples(out.q_tar, 1:length(ts));
    ws_rw = getdatasamples(out.w_rw, 1:length(ts));

    solar_panels = false;
    if ~(isempty(find(out, 'theta_sp1a')))
        solar_panels = true;
    end

    if (solar_panels)
        thetas_sp1a = getdatasamples(out.theta_sp1a, 1:length(ts));
        thetas_sp1b = getdatasamples(out.theta_sp1b, 1:length(ts));
        thetas_sp2a = getdatasamples(out.theta_sp2a, 1:length(ts));
        thetas_sp2b = getdatasamples(out.theta_sp2b, 1:length(ts));
        thetas_sp1a = permute(thetas_sp1a, [3, 1, 2]);
        thetas_sp1b = permute(thetas_sp1b, [3, 1, 2]);
        thetas_sp2a = permute(thetas_sp2a, [3, 1, 2]);
        thetas_sp2b = permute(thetas_sp2b, [3, 1, 2]);
    else
        thetas_sp1a = zeros(size(ts));
        thetas_sp1b = zeros(size(ts));
        thetas_sp2a = zeros(size(ts));
        thetas_sp2b = zeros(size(ts));
    end
    thetas = [thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b];

    %calculate error
    es = zeros(size(ts));
    for j = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, j), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, j), 'simulink', 'matlab');

        es(j) = dist(qm_tar, qm_acc);
    end
end