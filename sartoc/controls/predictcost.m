function cost = predictcost(loop_model, states_cur, pred_horizon, costfunction, g_test)
%predicts the cost using a model
%
%Arguments:
%   loop_model (str): the model to predict with
%   states_cur (Simulink.SimulationData.Dataset): the states to start from
%   pred_horizon (float): the horizon to predict for
%   costfunction (int): the parameter to select which cost function
%   g_test (nx1 array): vector of gains, currently 3x1 + 3x1
%
%Returns:
%   cost (float): the cost predicted from the model simulation

    %add values of k and lambda to base workspace
    assignin('base', 'k', g_test(1:3));
    assignin('base', 'lambda', g_test(4:6));
    
    %add values of initial states to workspace
    assignin('base', 'states_cur', states_cur);

    %sim
    out_pred = sim(loop_model, ...
                   'StopTime', num2str(pred_horizon), ...
                   'LoadInitialState', 'on', 'InitialState', 'states_cur');

    %gather data
    [ts, es, ws_rw, thetas, taus] = prepforcost(out_pred);

    %calculate cost
    cost = evaluatecost(costfunction, ts, es, ws_rw, thetas, taus) + 0.01*dot(g_test(1:3), g_test(1:3));
end