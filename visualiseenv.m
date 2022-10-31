function visualiseenv(offset)
    %sphere
    [xsphere, ysphere, zsphere] = sphere;
    s = surf(xsphere, ysphere, zsphere, 'DisplayName', 'Attitude Sphere');
    colormap(summer);
    s.LineStyle = ':';
    hold on
    
    %axis
    quiver3(0, 0, 0, 1.1*offset, 0, 0, 0, 'c', 'LineWidth', 1, 'DisplayName', 'x');
    quiver3(0, 0, 0, 0, 1.1*offset, 0, 0, 'm', 'LineWidth', 1, 'DisplayName', 'y');
    quiver3(0, 0, 0, 0, 0, 1.1*offset, 0, 'Color', '#EDB120', 'LineWidth', 1, 'DisplayName', 'z');