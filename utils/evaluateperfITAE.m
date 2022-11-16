function perf = evaluateperfITAE(t, err, norm)
%evaluates the performance using ITAE
%
%Arguments:
%   t (list(float)): list of times
%   err (list(float)): list of errors
%   norm (int): normalisation factor
%
%Returns:
%   float: the ITAE index

    arguments
        t
        err
        norm = 1
    end

    i = cumtrapz(t, t.*abs(err)/norm);
    perf = i(end);
end