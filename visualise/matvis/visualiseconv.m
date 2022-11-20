function visualiseconv(qs_acc, qs_tar, ts, p)
%visualises the convergence of the simulation
%
%Arguments:
%   qs_acc (array): the quaternion array for the actual state
%   qs_tar (array): the quaternion array for the target state
%   ts (array): the ts array
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   
%Returns:
%   None

    arguments
        qs_acc
        qs_tar
        ts
        p = [1, 0, 0]
    end

    %CALCULATE
    %iterate over ts
    thetas = zeros(length(ts), 1);
    for i = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');
    
        %find angular difference between target and state
        thetas(i) = dist(qm_acc, qm_tar);
    end

    %PLOT
    plot(ts, thetas, 'Color', [1, 0, 1]);
    xlabel('t (s)');
    ylabel('\delta\theta')
    title(['Convergence Plot, ITAE = ', num2str(evaluateperfITAE(ts, thetas))])