ph = [10, 25, 50, 100];
t_taken = [1009.7 1554.6 2454.1 5840.7];
sim_time = 200;
cont_update = 10;
no_updates = sim_time/cont_update;
t_taken_per_update = t_taken/no_updates;

scatter(ph, t_taken_per_update, 'filled', 'MarkerFaceColor', [0 .6 0]);
hold on
xlabel('$T_p$ (s)', 'interpreter', 'latex')
ylabel('Real Time Taken Per Control Update (s)', 'interpreter', 'latex')
xlim([0 110])
ylim([0 300])

coeff = polyfit(ph, t_taken_per_update, 2);
ph_fit = 0:300;
t_taken_per_update_fit = polyval(coeff, ph_fit);
plot(ph_fit, t_taken_per_update_fit, ':', 'Color', [0 .6 0])
hold off