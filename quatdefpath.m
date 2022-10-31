%INPUT
offset = 1.05;

%CALCULATE
%generate param lengths
ts = 0:pi/48:(2+1/48)*pi;
qms = zeros(length(ts) - 1, 1, 'quaternion');
rs = zeros(length(ts) - 1, 3);

%iterate over paramter
for i = 1:length(ts)-1
    %find theta, phi from function
    [theta, phi] = testPath(ts(i));

    %convert spherical to qm
    qms(i) = quaternion(0, cos(theta)*sin(phi), sin(theta)*sin(phi), cos(phi));

    %convert qm to cartesian
    rs(i, :) = offset*quat2vec(qms(i), 'matlab', 'cartesian');
end

%PLOT
visualiseenv(offset)

%data
plot3(rs(:, 1), rs(:, 2), rs(:, 3))

legend('Location', 'northeast');

%----------------------------------
function [theta, phi] = testPath(t)
    theta = t;
    phi = t;
end