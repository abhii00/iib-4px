function visualiseenv(offset)
%plots the environment including the sphere, and the axes
%
%Arguments:
%   offset (float): the offset of the data so to alter the axes plots
%
%Returns:
%   None

    %sphere
    [xsphere, ysphere, zsphere] = sphere;
    s = surf(xsphere, ysphere, zsphere, 'DisplayName', 'Attitude Sphere');
    colormap(copper);
    s.LineStyle = ':';
    hold on
    
    %axis
    quiver3(0, 0, 0, 1.1*offset, 0, 0, 0, 'y', 'LineWidth', 1, 'DisplayName', 'x');
    quiver3(0, 0, 0, 0, 1.1*offset, 0, 0, 'm', 'LineWidth', 1, 'DisplayName', 'y');
    quiver3(0, 0, 0, 0, 0, 1.1*offset, 0, 'c', 'LineWidth', 1, 'DisplayName', 'z');