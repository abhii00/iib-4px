disturbances

t = [0 99 100 400];
x = [0.05 0.05 -0.05 -0.05];
y = [0.05 0.05 -0.05 -0.05];
z = [0 0 0 0]

plot(t, x, t, y, '--', t, z)
xlabel('t (s)')
ylabel('Disturbance Torque (Nm)')
legend('x comp.', 'y comp.', 'z comp')
xlim([0 400])
ylim([-0.06 0.06])