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

        %rotate p using qm data
        p_acc = rotatepoint(qm_acc, p);
        p_tar = rotatepoint(qm_tar, p);
    
        %find angular difference between target and state
        thetas(i) = atan2(norm(cross(p_acc,p_tar)),dot(p_acc,p_tar));
    end

    %PLOT
    plot(ts, thetas, 'Color', [1, 0, 1]);
    xlabel('t (s)');
    ylabel('\delta\theta');
    title(['Convergence Plot, ITAE = ', num2str(evaluateperfITAE(ts, thetas))]);
end