function visualisecont(ws_rw, taus, ts, ks, lambdas, tgs, fn)
%visualises the control parameters of the simulation
%
%Arguments:
%   ws_rw (array): the reaction wheel speeds
%   taus (array): the distributed torques
%   ts (array): the ts array for the 
%   ks (array): the proportional gains
%   lambdas (array): the derivative gains
%   tgs (array): the tcs array for the gains
%   fn (str): the file name to save to
%   
%Returns:
%   None

    %PLOT
    %reaction wheel speeds
    figure;
    plot(ts, ws_rw);
    xlabel('t (s)');
    ylabel('\omega_{rw}');
    title('Reaction Wheel Speeds');
    legend('\omega_{rw1}', '\omega_{rw2}', '\omega_{rw3}', '\omega_{rw4}');
    saveas(gcf, [fn '_wrw.png']);

    %torques
    figure;
    plot(ts, taus);
    xlabel('t (s)');
    ylabel('\tau');
    title('Torques');
    legend('\tau_1', '\tau_2', '\tau_3', '\tau_4');
    saveas(gcf, [fn '_tau.png']);

    %ks
    figure;
    plot(tgs, ks);
    xlabel('t (s)');
    ylabel('k');
    title('Proportional Gains');
    legend('k_1', 'k_2', 'k_3');
    saveas(gcf, [fn '_k.png']);

    %lambdas
    figure;
    plot(tgs, lambdas);
    xlabel('t (s)');
    ylabel('\lambda');
    title('Derivative Gains');
    legend('\lambda_1', '\lambda_2', '\lambda_3');
    saveas(gcf, [fn '_lambda.png']);
end