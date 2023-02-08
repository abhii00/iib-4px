function perf = evaluateperfITAE(ts, err, norm)
%evaluates the performance using ITAE
%
%Arguments:
%   ts (list(float)): list of times
%   err (list(float)): list of errors
%   norm (int): normalisation factor
%
%Returns:
%   float: the ITAE index

    arguments
        ts
        err
        norm = 1
    end

    i = cumtrapz(ts, ts.*abs(err)/norm);
    perf = i(end);
end