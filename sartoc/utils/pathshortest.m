function pathshortest(qm_1, qm_2, N, p, offset)
%plots the shortest path between two given quaternion pointings of an axis
%with a given discretisation
%
%Arguments:
%   qm_1 (quaternion): the quaternion to start the path at
%   qm_2 (quaternion): the quaternion to end the path at
%   N (int): the number of points on the path (including start and end)
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   offset (float): the offset for the points, defaults to 1.05
%
%Returns:
%   None

    arguments
        qm_1
        qm_2
        N
        p = [1, 0, 0]
        offset = 1.05
    end

    %CALCULATE
    %interpolate
    qms = slerp(qm_1, qm_2, linspace(0, 1, N));
    qms = qms(2:end-1);

    %rotate p using interpolated qm
    rs = zeros(length(qms), 3);
    for i = 1:length(qms)
        rs(i, :) = offset * rotatepoint(qms(i), p);
    end

    %rotate p using initial and final qm
    r1 = offset * rotatepoint(qm_1, p);
    r2 = offset * rotatepoint(qm_2, p);

    %PLOT
    visualiseenv(offset);
    
    %initial and end
    scatter3(r1(1), r1(2), r1(3), 'bo', 'LineWidth', 1.5, 'DisplayName', 'Initial State');
    scatter3(r2(1), r2(2), r2(3), 'bx', 'LineWidth', 1.5, 'DisplayName', 'Final State');
    
    %interpolated data
    scatter3(rs(:, 1), rs(:, 2), rs(:, 3), 'filled', 'bo', 'LineWidth', 1.5, 'DisplayName', 'Interpolated States');
    
    %add legend
    legend('Location','northeast');
end