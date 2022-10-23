%generate param lengths
ts = 0:pi/48:(2+1/48)*pi;
qs = zeros(length(ts) - 1, 1, 'quaternion');
rs = zeros(length(ts) - 1, 3);

%rotate entire system
W = pi/2 * [0, 0, 1];
qW = quaternion(W, 'rotvec');

%find theta, phi, q, r
for i = 1:length(ts)-1
    [theta, phi] = testPath(ts(i));
    qs(i) = quaternion(0, cos(theta)*sin(phi), sin(theta)*sin(phi), cos(phi)) * qW;
    [a, b, c, d] = parts(qs(i));
    rs(i, :) = [b, c, d]/norm([b, c, d]);
end

%unpack into x, y, z
r = 1;
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

function [theta, phi] = testPath(t)
    theta = t;
    phi = t;
end