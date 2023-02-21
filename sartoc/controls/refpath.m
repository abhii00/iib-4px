function q_tar = refpath(t, a)
%function to provide a reference path i.e. q_tar(t)
%
%Arguments:
%   t (float): parameter, usually time, to select point in path
%   a (int): parameter to select which path
%
%Returns:
%   q_tar (4x1 array): the target quaternion
    
    switch(a)
        case 2
            %0 -> PI/4 AROUND YZ WITH 10 STEPS
            N = 10;
            qm_1 = quatconstruct([0, 0, 0], 'rotation', 'matlab');
            qm_2 = quatconstruct(pi/4*[0, 1, 1]/norm([0, 1, 1]), 'rotation', 'matlab');
            qms = slerp(qm_1, qm_2, linspace(0, 1, N));
            i = floor(t * N/1000) + 1;
            if i <= N
                qm_tar = qms(i);
            else
                qm_tar = qms(N);
            end
        case 3
            tm = t - 450;
            qm_tar = quatconstruct(2*pi*tm/1000*[0, 1, 1]/norm([0, 1, 1]), 'rotation', 'matlab');
        case 1
            qm_tar = quatconstruct(pi/2*[0, 1, 1]/norm([0, 1, 1]), 'rotation', 'matlab');
    end
    q_tar = quatconvert(qm_tar, 'matlab', 'simulink');
end