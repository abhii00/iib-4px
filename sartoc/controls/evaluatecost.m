function cost = evaluatecost(costfunction, ts, es)
%evaluates the cost function
%
%Arguments:
%   costfunction (int): parameter to select which cost function
%   ts (list(float)): list of times
%   es (list(float)): list of errors
%
%Returns:
%   float: the cost

    switch(costfunction)
        case 1
            %e^2
            cumcost = cumtrapz(ts, es.^2);
            cost = cumcost(end);
        otherwise
            %no cost
            cost = 0;
    end
end