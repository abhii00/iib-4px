rs = zeros(length(out.tout), 3);
Q_cur = getdatasamples(out.Q_cur, 1:length(out.tout));
for i = 1:length(out.tout)
    Qm_cur = quaternion(Q_cur(:, :, i).');
    [a, b, c, d] = parts(Qm_cur);
    rs(i, :) = [b, c, d]/norm([b, c, d]);
end

%unpack into x, y, z
r = 1.05;
xs = r*rs(:, 1);
ys = r*rs(:, 2);
zs = r*rs(:, 3);

%find sphere
[xsphere, ysphere, zsphere] = sphere;

%plot
s = surf(xsphere, ysphere, zsphere);
s.EdgeColor = 'none';
hold on
plot3(xs, ys, zs)