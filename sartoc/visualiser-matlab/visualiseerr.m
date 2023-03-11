function visualiseerr(qs_acc, qs_tar, ts, fn, p)
%visualises the error of the simulation over time
%
%Arguments:
%   qs_acc (array): the quaternion array for the actual state
%   qs_tar (array): the quaternion array for the target state
%   ts (array): the ts array
%   fn (string): the file name to save to
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%      
%Returns:
%   None

    arguments
        qs_acc
        qs_tar
        ts
        fn
        p = [1, 0, 0]
    end

    %CALCULATE
    %iterate over ts
    es = zeros(length(ts), 1);
    for i = 1:length(ts)
        %convert from q to qm
        qm_acc = quatconvert(qs_acc(:, :, i), 'simulink', 'matlab');
        qm_tar = quatconvert(qs_tar(:, :, i), 'simulink', 'matlab');
    
        %find angular difference between target and state
        es(i) = dist(qm_acc, qm_tar);
    end

    %PLOT
    figure;
    plot(ts, es, 'Color', [1, 0, 1]);
    xlabel('t (s)');
    ylabel('\delta\theta');
    title(['Error, C = ', num2str(evaluatecost(ts, es))]);
    saveas(gcf, [fn '_err.png']);
end