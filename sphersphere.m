% find sphere coords
[xsphere, ysphere, zsphere] = sphere;

%find path coords
ts = 0:pi/48:(2+1/48)*pi;
xs = zeros(1, length(ts));
ys = zeros(1, length(ts));
zs = zeros(1, length(ts));
theta = 0;
phi = 0;
r = 1;
for i = 1:length(ts)
    [theta, phi] = testPath(ts(i));
    xs(i) = r*sin(theta)*cos(phi);
    ys(i) = r*sin(theta)*sin(phi);
    zs(i) = r*cos(theta);
end

%plot
s = surf(xsphere, ysphere, zsphere);
s.EdgeColor = 'none';
hold on
plot3(xs, ys, zs)

%path to plot
function [theta, phi] = testPath(t)
    theta = t;
    phi = t;
end