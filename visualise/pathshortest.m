function pathshortest(qm_1, qm_2, N, offset)
%plots the shortest path between two given quaternions with a given
%discretisation
%
%Arguments:
%   qm_1 (quaternion): the quaternion to start the path at
%   qm_2 (quaternion): the quaternion to end the path at
%   N (int): the number of points on the path (including start and end)
%   offset (float): the offset for the points, defaults to 1.05
%
%Returns:
%   None

    arguments
        qm_1
        qm_2
        N
        offset = 1.05
    end

    %CALCULATE
    %interpolate
    qms = slerp(qm_1, qm_2, linspace(0, 1, N));
    qms = qms(2:end-1);

    %convert interpolated from qm into cartesian
    rs = zeros(length(qms), 3);
    for i = 1:length(qms)
        rs(i, :) = offset*quatdeconstruct(qms(i), 'matlab', 'cartesian');
    end

    %convert initial and end from qm into cartesian
    r1 = offset*quatdeconstruct(qm_1, 'matlab', 'cartesian');
    r2 = offset*quatdeconstruct(qm_2, 'matlab', 'cartesian');

    %PLOT
    visualiseenv(offset)
    
    %initial and end
    scatter3(r1(1), r1(2), r1(3), 'bo', 'DisplayName', 'Initial State');
    scatter3(r2(1), r2(2), r2(3), 'bx', 'DisplayName', 'Final State');
    
    %interpolated data
    scatter3(rs(:, 1), rs(:, 2), rs(:, 3), 'filled', 'bo', 'DisplayName', 'Interpolated States');
    
    %add legend
    legend('Location','northeast');