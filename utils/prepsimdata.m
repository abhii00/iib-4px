function [tout, Qs_sta, Qs_tar] = prepsimdata(out, fn)
%loads simulation data into workspace and saves
%
%Arguments:
%   out (SimulationOutput): the output data
%
%Returns:
%   none
    tout = out.tout;
    Qs_sta = getdatasamples(out.Q_cur, 1:length(out.tout));
    Qs_tar = getdatasamples(out.Q_tar, 1:length(out.tout));
    save(fn, 'tout', 'Qs_sta', 'Qs_tar');

    csvo = [tout, permute(Qs_sta, [3, 1, 2]), permute(Qs_tar, [3, 1, 2])];
    writematrix(csvo, [fn, '.csv'])