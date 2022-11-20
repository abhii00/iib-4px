function visualisetraj(qs_acc, qs_tar, ts, p, offset, speed)
%visualises the results of the simulation
%
%Arguments:
%   qs_acc (array): the quaternion array for the actual state
%   qs_tar (array): the quaternion array for the target state
%   ts (array): the ts array
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   offset (float): the offset for the points, defaults to 1.05
%   speed (float): time scale factor
%
%Returns:
%   None

    arguments
        qs_acc
        qs_tar
        ts
        p = [1, 0, 0]
        offset = 1.05
        speed = 1
    end
    
    %CALCULATE
    %iterate over ts
    rs_acc = zeros(length(ts), 3);
    rs_tar = zeros(length(ts), 3);
    for i = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');
    
        %rotate p using qm data
        rs_acc(i, :) = offset * rotatepoint(qm_acc, p);
        rs_tar(i, :) = offset * rotatepoint(qm_tar, p);
    end
    
    %PLOT
    visualiseenv(offset)
    
    %initial actual and setup for animation
    s = animatedline(rs_acc(1, 1), rs_acc(1, 2), rs_acc(1, 3), 'Color', 'r', 'DisplayName', 'Actual');
    sp = scatter3(rs_acc(1, 1), rs_acc(1, 2), rs_acc(1, 3), 'filled', 'ro', 'DisplayName', 'Current Actual');
    scatter3(rs_acc(1, 1), rs_acc(1, 2), rs_acc(1, 3), 'ro', 'DisplayName', 'Initial State');
    
    %initial target and setup for animation
    t = animatedline(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'Color', 'g', 'DisplayName', 'Target');
    tp = scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'filled', 'go', 'DisplayName', 'Current Target');
    scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'go', 'DisplayName', 'Initial Target');
    
    %add legend
    legend('Location','northeast');

    %track actual
    view(rad2deg(atan2(rs_acc(1, 2), rs_acc(1, 1))) + 90, rad2deg(asin(rs_acc(1, 3)/offset)));
    
    %animate
    for k = 2:length(ts)
        if mod(k, speed) == 0
            %update actual
            addpoints(s, rs_acc(k, 1), rs_acc(k, 2), rs_acc(k, 3));
            sp.XData = rs_acc(k, 1);
            sp.YData = rs_acc(k, 2);
            sp.ZData = rs_acc(k, 3);
        
            %update target
            addpoints(t, rs_tar(k, 1), rs_tar(k, 2), rs_tar(k, 3));
            tp.XData = rs_tar(k, 1);
            tp.YData = rs_tar(k, 2);
            tp.ZData = rs_tar(k, 3);
        
            %update title and view
            title(['t = ', num2str(ts(k)), 's']);
            view(rad2deg(atan2(rs_acc(k, 2), rs_acc(k, 1))) + 90, rad2deg(asin(rs_acc(k, 3)/offset)));
            drawnow
        end
    end
    
    %final actual and target and delete animation
    delete(sp);
    delete(tp);
    scatter3(rs_acc(end, 1), rs_acc(end, 2), rs_acc(end, 3), 'rx', 'DisplayName', 'Final Actual');
    scatter3(rs_tar(end, 1), rs_tar(end, 2), rs_tar(end, 3), 'gx', 'DisplayName', 'Final Target');
    
    %readd legend
    legend('Location','northeast');