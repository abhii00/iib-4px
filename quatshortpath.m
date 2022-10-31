%INPUT
offset = 1.05;
%enter two pairs of theta and phi, and number of divisions N
theta1 = 0;
phi1 = pi/4;
theta2 = pi/2;
phi2 = pi/2;
N = 10;

%CALCULATION
%convert from spherical to qm
qm_1 = quaternion(0, cos(theta1)*sin(phi1), sin(theta1)*sin(phi1), cos(phi1));
qm_2 = quaternion(0, cos(theta2)*sin(phi2), sin(theta2)*sin(phi2), cos(phi2));

%interpolate
qms = slerp(qm_1, qm_2, linspace(0, 1, N));
qms = qms(2:end-1);

%convert interpolated from qm into cartesian
rs = zeros(length(qms), 3);
for i = 1:length(qms)
    rs(i, :) = offset*quat2vec(qms(i), 'matlab', 'cartesian');
end

%convert initial and end from qm into cartesian
r1 = offset*quat2vec(qm_1, 'matlab', 'cartesian');
r2 = offset*quat2vec(qm_2, 'matlab', 'cartesian');

%PLOT
visualiseenv(offset)

%initial and end
scatter3(r1(1), r1(2), r1(3), 'bo', 'DisplayName', 'Initial State');
scatter3(r2(1), r2(2), r2(3), 'bx', 'DisplayName', 'Final State');

%interpolated data
scatter3(rs(:, 1), rs(:, 2), rs(:, 3), 'filled', 'bo', 'DisplayName', 'Interpolated States');

%add legend
legend('Location','northeast');