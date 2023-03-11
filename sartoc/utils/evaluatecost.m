function cost = evaluatecost(ts, es)
%evaluates the cost function
%
%Arguments:
%   ts (list(float)): list of times
%   es (list(float)): list of errors
%
%Returns:
%   float: the cost

    costfunct = cumtrapz(ts, es.^2);
    cost = costfunct(end);
end