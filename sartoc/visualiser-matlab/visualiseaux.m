function visualiseaux(thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b, xs_ls, ts, fn)
%visualises the control parameters of the simulation
%
%Arguments:
%   thetas_sp1a (array): the array of theta sp1a
%   thetas_sp1b (array): the array of theta sp1b
%   thetas_sp2a (array): the array of theta sp2a
%   thetas_sp2b (array): the array of theta sp2b
%   xs_ls (array): the array of displacement ls
%   ts (array): the ts array
%   
%Returns:
%   None

    %PLOT
    solar_panels = false;
    liquid_slosh = false;
    if ~all(thetas_sp1a == 0)
        solar_panels = true;
    end
    if ~all(xs_ls == 0)
        liquid_slosh = true;
    end

    %thetas
    if (solar_panels)
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

    %x
    if (liquid_slosh)
        figure;
        plot(ts, xs_ls);
        xlabel('t (s)');
        ylabel('Displacement (m)');
        title('Liquid Slosh Displacement');
        legend('x', 'y', 'z');
        saveas(gcf, [fn '_ls.png']);
    end
end