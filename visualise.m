function visualise(Qs_sta, Qs_tar, tout, p, offset)
%visualises the results of the simulation
%
%Arguments:
%   Qs_sta (array): the quaternion array for the states
%   Qs_tar (array): the quaternion array for the target
%   tout (array): the time array
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   offset (float): the offset for the points, defaults to 1.05
%   
%Returns:
%   None

    arguments
        Qs_sta
        Qs_tar
        tout
        p = [1, 0, 0]
        offset = 1.05
    end
    
    %CALCULATE
    %iterate over time
    rs_sta = zeros(length(tout), 3);
    rs_tar = zeros(length(tout), 3);
    for i = 1:length(out.tout)
        %convert from q to qm
        qm_sta = quatconvert(Qs_sta(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(Qs_tar(:, :, i), 'simulink', 'matlab');
    
        %rotate p to correct orientation
        rs_sta(i, :) = offset * rotatepoint(qm_sta, p);
        rs_tar(i, :) = offset * rotatepoint(qm_tar, p);
    end
    
    %PLOT
    visualiseenv(offset)
    
    %initial states and setup for animation
    s = animatedline(rs_sta(1, 1), rs_sta(1, 2), rs_sta(1, 3), 'Color', 'r', 'DisplayName', 'State');
    sp = scatter3(rs_sta(1, 1), rs_sta(1, 2), rs_sta(1, 3), 'filled', 'ro', 'DisplayName', 'Current State');
    scatter3(rs_sta(1, 1), rs_sta(1, 2), rs_sta(1, 3), 'ro', 'DisplayName', 'Initial State');
    
    %initial target and setup for animation
    t = animatedline(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'Color', 'g', 'DisplayName', 'Target');
    tp = scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'filled', 'go', 'DisplayName', 'Current Target');
    scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'go', 'DisplayName', 'Initial Target');
    
    %add legend
    legend('Location','northeast');

    %track state
    view(rad2deg(atan2(rs_sta(1, 2), rs_sta(1, 1))) + 90, rad2deg(asin(rs_sta(1, 3)/offset)));
    
    %animate
    for k = 2:length(tout)
        if mod(k, 1) == 0
            %update state
            addpoints(s, rs_sta(k, 1), rs_sta(k, 2), rs_sta(k, 3));
            sp.XData = rs_sta(k, 1);
            sp.YData = rs_sta(k, 2);
            sp.ZData = rs_sta(k, 3);
        
            %update targets
            addpoints(t, rs_tar(k, 1), rs_tar(k, 2), rs_tar(k, 3));
            tp.XData = rs_tar(k, 1);
            tp.YData = rs_tar(k, 2);
            tp.ZData = rs_tar(k, 3);
        
            title(out.tout(k));
            view(rad2deg(atan2(rs_sta(k, 2), rs_sta(k, 1))) + 90, rad2deg(asin(rs_sta(k, 3)/offset)));
            drawnow limitrate;
        end
    end
    
    %final state and target and delete animation
    delete(sp);
    delete(tp);
    scatter3(rs_sta(end, 1), rs_sta(end, 2), rs_sta(end, 3), 'rx', 'DisplayName', 'Final State');
    scatter3(rs_tar(end, 1), rs_tar(end, 2), rs_tar(end, 3), 'gx', 'DisplayName', 'Final Target');
    
    %readd legend
    legend('Location','northeast');