function pathdefined(ts, path, offset)
%plots a given parameterised path
%
%Arguments:
%   ts (array(float)): the list of parameters to plot for
%   path (handle): the handle to the path function
%   offset (float): the offset for the points, defaults to 1.05
%
%Returns:
%   None

    arguments
        ts
        path
        offset = 1.05
    end
  
    %CALCULATE
    %generate param lengths
    qms = zeros(length(ts) - 1, 1, 'quaternion');
    rs = zeros(length(ts) - 1, 3);
    
    %iterate over paramter
    for i = 1:length(ts)-1
        %find theta, phi from function
        [theta, phi] = path(ts(i));
    
        %convert spherical to qm
        qms(i) = quatconstruct([1, theta, phi], 'spherical', 'matlab');
    
        %convert qm to cartesian
        rs(i, :) = offset*quatdeconstruct(qms(i), 'matlab', 'cartesian');
    end
    
    %PLOT
    visualiseenv(offset)
    
    %data
    plot3(rs(:, 1), rs(:, 2), rs(:, 3), 'b')
    
    %add legend
    legend('Location', 'northeast');