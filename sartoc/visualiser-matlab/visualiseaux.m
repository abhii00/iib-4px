function visualiseaux(thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, ts, fn)
%visualises the control parameters of the simulation
%
%Arguments:
%   thetas_sp1a (array): the array of theta sp1a
%   thetas_sp1b (array): the array of theta sp1b
%   thetas_sp2a (array): the array of theta sp2a
%   thetas_sp2b (array): the array of theta sp2b
%   ts (array): the ts array
%   
%Returns:
%   None

    %PLOT
    %thetas
    figure;
    plot(ts, thetas_sp1a);
    hold on
    plot(ts, thetas_sp1b);
    plot(ts, thetas_sp2a);
    plot(ts, thetas_sp2b);
    xlabel('t (s)');
    ylabel('\theta');
    title('Solar Panel \theta');
    legend('\theta_{sp1a}', '\theta_{sp1b}', '\theta_{sp2a}', '\theta_{sp2b}');
    saveas(gcf, [fn '_theta.png']);
end