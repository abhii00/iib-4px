p = [1, 0, 0];
offset = 1.05;
ts = 1:100;

qm_1 = quaternion(1, 0, 0, 0);
qm_2 = quatconstruct(pi/2*[0, 1, 1]/norm([0, 1, 1]), 'rotation', 'matlab');
qms = slerp(qm_1, qm_2, linspace(0, 1, length(ts)));

%CALCULATE
%iterate over ts
rs_tar = zeros(length(ts), 3);
for i = 1:length(ts)
    %rotate p using qm data
    rs_tar(i, :) = offset * rotatepoint(qms(i), p);
end

%PLOT
figure;
[xsphere, ysphere, zsphere] = sphere;
s = mesh(xsphere, ysphere, zsphere, 'DisplayName', 'Unit Sphere', 'FaceAlpha', '0.7');
colormap([0.5  0.5  0.5])
xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-1.5 1.5])
hold on

%axis
quiver3(0, 0, 0, 1.1*offset, 0, 0, 0, 'Color', '#aa00aa', 'LineWidth', 1, 'DisplayName', 'x');
quiver3(0, 0, 0, 0, 1.1*offset, 0, 0, 'Color', '#aaaa00', 'LineWidth', 1, 'DisplayName', 'y');
quiver3(0, 0, 0, 0, 0, 1.1*offset, 0, 'Color', '#00aaaa', 'LineWidth', 1, 'DisplayName', 'z');

%initial target and setup for animation
t = animatedline(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'Color', 'g', 'LineWidth', 1.5, 'DisplayName', 'Slewing Manouevre');
tp = scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'filled', 'go', 'LineWidth', 1.5, 'DisplayName', 'Current Target');
scatter3(rs_tar(1, 1), rs_tar(1, 2), rs_tar(1, 3), 'go', 'LineWidth', 1.5, 'DisplayName', 'Reference at $t=0$');

%add legend
legend('Location','northeast');

%animate
for k = 2:length(ts)
    %update target
    addpoints(t, rs_tar(k, 1), rs_tar(k, 2), rs_tar(k, 3));
    tp.XData = rs_tar(k, 1);
    tp.YData = rs_tar(k, 2);
    tp.ZData = rs_tar(k, 3);

    %update title and view
    drawnow limitrate
end

%final actual and target and delete animation
delete(tp);
scatter3(rs_tar(end, 1), rs_tar(end, 2), rs_tar(end, 3), 'gx', 'LineWidth', 1.5, 'DisplayName', 'Reference for $t>0$');

%readd legend
legend('Location','northeast', 'interpreter', 'latex');