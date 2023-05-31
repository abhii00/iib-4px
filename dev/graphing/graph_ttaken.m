t_p = [50, 100];

t_taken = [2323.2 5319.4 6104.2; 5282.8 9667.8 10290.8];
sim_time = [200 400 400; 200 400 400];
cont_update = 10;
no_updates = sim_time/cont_update;
t_taken_per_update = t_taken./no_updates;

b = bar(t_p, t_taken_per_update, 'FaceColor','flat');
xlabel('$T_p$ (s)', 'interpreter', 'latex')
ylabel('Real Time Taken Per Control Update (s)', 'interpreter', 'latex')
ylim([0 375])

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(round(b(1).YData));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(round(b(2).YData));
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
xtips3 = b(3).XEndPoints;
ytips3 = b(3).YEndPoints;
labels3 = string(round(b(3).YData));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');

colormap(summer)
b(1).CData = 1;
b(2).CData = 2;
b(3).CData = 3;

legend(b,{'Cube','Realistic Inertia','Cube with SP'})