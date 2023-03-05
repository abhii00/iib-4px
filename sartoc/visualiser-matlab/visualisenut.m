function visualisenut(qs_acc, qs_tar, ts, p)
%visualises the nutation in the simulation
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
    dphi = zeros(length(ts), 1);
    dtheta = zeros(length(ts), 1);
    for i = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');

        %rotate p using qm data
        p_acc = rotatepoint(qm_acc, p);
        p_tar = rotatepoint(qm_tar, p);
    
        %find angular differences between target and state
        dphi(i) = atan2(p_acc(2),p_acc(1)) - atan2(p_tar(2),p_tar(1));
        dtheta(i) = atan2(sqrt(p_acc(1)^2 + p_acc(2)^2),p_acc(3)) - atan2(sqrt(p_tar(1)^2 + p_tar(2)^2),p_tar(3));
    end

    %PLOT
    plot(ts, dphi, 'Color', [1, 0, 1]);
    hold on
    plot(ts, dtheta, 'Color', [0, 0, 1]);
    hold off
    xlabel('t (s)');
    ylabel('Change in Angle');
    title('Convergence Plot');
    legend(['Phi', 'Theta']);
end