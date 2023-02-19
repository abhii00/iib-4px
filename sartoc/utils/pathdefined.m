function pathdefined(ts, path, p, offset)
%plots a parametrised quaternion axis pointing for a given path
%
%Arguments:
%   ts (array(float)): the list of parameters to plot for
%   path (handle): the handle to the Q(t) path function
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   offset (float): the offset for the points, defaults to 1.05
%
%Returns:
%   None

    arguments
        ts
        path
        p = [1, 0, 0]
        offset = 1.05
    end
  
    %CALCULATE
    %generate param lengths
    qms = zeros(length(ts) - 1, 1, 'quaternion');
    rs = zeros(length(ts) - 1, 3);
    
    %iterate over paramter
    for i = 1:length(ts)-1
        %find qm from path
        qms(i) = path(ts(i));
    
        %rotate p using qm    
        %convert qm to cartesian
        rs(i, :) = offset * rotatepoint(qms(i), p);
    end
    
    %PLOT
    visualiseenv(offset)
    
    %data
    plot3(rs(:, 1), rs(:, 2), rs(:, 3), 'b', 'LineWidth', 2)
    
    %add legend
    legend('Location', 'northeast');
end