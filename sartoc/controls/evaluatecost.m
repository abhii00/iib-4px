function cost = evaluatecost(costfunction, ts, es, ws_rw, thetas, taus)
%evaluates the cost function
%
%Arguments:
%   costfunction (int): parameter to select which cost function
%   ts (list(float)): list of times
%   es (list(float)): list of errors
%   ws_rw (array(float)): array of reaction wheel velocities
%   thetas (array(float)): array of solar panel thetas
%   taus (array(float)): array of control torques
%
%Returns:
%   float: the cost

    switch(costfunction)
        case 1
            %e^2
            cumcost = cumtrapz(ts, es.^2);
            cost = cumcost(end);
        case 2
            %e^2 + Mtau^2
            M = 0.25;
            cumcost = cumtrapz(ts, es.^2 + M*dot(taus, taus, 2));
            cost = cumcost(end);
        case 3
            %e^2 + Qthetas^2
            Q = 2.5e4;
            cumcost = cumtrapz(ts, es.^2 + Q*dot(thetas, thetas, 2));
            cost = cumcost(end);
        otherwise
            %no cost
            cost = 0;
    end
end