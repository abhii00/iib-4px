function visualiseperf(qs_acc, qs_tar, ws_rw, thetas, taus, ts, costfunction, rt_taken, fn)
%visualises the error of the simulation over time
%
%Arguments:
%   qs_acc (array): the quaternion array for the actual state
%   qs_tar (array): the quaternion array for the target state
%   ws_rw (array): the array of reaction wheel velocities
%   thetas (array): the array of solar panel angles
%   taus (array): the array of control torques
%   ts (array): the ts array
%   costfunction (int): the cost function to use
%   rt_taken (float): the real time taken for the simulation
%   fn (string): the file name to save to
%      
%Returns:
%   None

    %CALCULATE
    %iterate over ts
    es = zeros(length(ts), 1);
    for i = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');
    
        %find angular difference between target and state
        es(i) = dist(qm_acc, qm_tar);
    end

    %PLOT
    figure;
    plot(ts, es, 'Color', [1, 0, 1]);
    xlabel('t (s)');
    ylabel('\delta\theta');
    title(['Error, C = ' num2str(evaluatecost(costfunction, ts, es, ws_rw, thetas, taus)) ', TTaken = ' num2str(rt_taken) 's']);
    saveas(gcf, [fn '_err.png']);
end