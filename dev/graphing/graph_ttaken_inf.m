t = [2*mean([295.1, 425.8]), mean([635, 641.5]), mean([690.9, 839.6, 718.9])];
x = categorical({'Cube', 'Realistic Inertia', 'Cube with SP'});
x = reordercats(x, {'Cube', 'Realistic Inertia', 'Cube with SP'});

b = bar(x, t, 'FaceColor', 'Flat');
ylabel('Average Real Time Taken for Optimisation (s)', 'interpreter', 'latex')
ylim([0 1000])

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(round(b(1).YData));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');

cmap = summer(3);
b.CData(1,:) = cmap(1, :);
b.CData(2,:) = cmap(2, :);
b.CData(3,:) = cmap(3, :);