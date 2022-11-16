function visualiseconv(Qs_sta, Qs_tar, tout, p)
%visualises the convergence of the simulation
%
%Arguments:
%   Qs_sta (array): the quaternion array for the states
%   Qs_tar (array): the quaternion array for the target
%   tout (array): the time array
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   
%Returns:
%   None

    arguments
        Qs_sta
        Qs_tar
        tout
        p = [1, 0, 0]
    end

    %CALCULATE
    %iterate over time
    thetas = zeros(length(tout), 1);
    for i = 1:length(tout)
        %convert from q to qm
        qm_sta = quatconvert(Qs_sta(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(Qs_tar(:, :, i), 'simulink', 'matlab');
    
        %find angular difference between target and state
        thetas(i) = dist(qm_sta, qm_tar);
    end

    %PLOT
    plot(tout, thetas, 'Color', [1, 0, 1]);
    xlabel('t (s)');
    ylabel('\delta\theta')
    title(['Convergence Plot, ITAE = ', num2str(evaluateperfITAE(tout, thetas))])