function [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls] = prepaux(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%   fn (str): the file name to save to
%
%Returns:
%   [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls]: the time, the four solar
%   panel rotation arrays and the liquid slosh displacement

    ts = out.tout;
    
    solar_panels = false;
    liquid_slosh = false;
    if ~(isempty(find(out, 'theta_sp1a')))
        solar_panels = true;
    end
    if ~(isempty(find(out, 'x_ls')))
        liquid_slosh = true;
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

    if (liquid_slosh)
        xs_ls = getdatasamples(out.x_ls, 1:length(ts));
    else
        xs_ls = zeros(size(ts));
    end

    save([fn, '_aux.mat'], 'ts', 'thetas_sp1a', 'thetas_sp1b', 'thetas_sp2a', 'thetas_sp2b', 'xs_ls');

    csvo = [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls];
    writematrix(csvo, [fn, '_aux.csv']);
end