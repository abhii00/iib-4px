function cost = evaluatecost(costfunction, ts, es, ws_rw, thetas)
%evaluates the cost function
%
%Arguments:
%   costfunction (int): parameter to select which cost function
%   ts (list(float)): list of times
%   es (list(float)): list of errors
%   ws_rw (array(float)): array of reaction wheel velocities
%   thetas (array(float)): array of solar panel thetas
%
%Returns:
%   float: the cost

    switch(costfunction)
        case 1
            %e^2
            cumcost = cumtrapz(ts, es.^2);
            cost = cumcost(end);
        case 2
            %e^2 + Mw_rw^2
            M = 5e-6;
            cumcost = cumtrapz(ts, es.^2 + M*dot(ws_rw, ws_rw, 2));
            cost = cumcost(end);
        case 3
            %e^2 + Qthetas^2
            Q = 2.5e4;
            cumcost = cumtrapz(ts, es.^2 + Q*dot(thetas, thetas, 2));
            cost = cumcost(end);
        case 4
            %e^2 + Mw_rw^2
            M = 7e-7;
            cumcost = cumtrapz(ts, es.^2 + M*dot(ws_rw, ws_rw, 2));
            cost = cumcost(end);
        case 5
            %e^2 + Mw_rw^2
            M = 1.5e-4;
            cumcost = cumtrapz(ts, es.^2 + M*dot(ws_rw, ws_rw, 2));
            cost = cumcost(end);
        otherwise
            %no cost
            cost = 0;
    end
end