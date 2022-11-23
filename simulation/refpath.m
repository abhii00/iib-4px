function q_tar = refpath(t, a)
%function to provide a reference path
%
%Arguments:
%   t (float): parameter, usually time, to select point in path
%   a (int): parameter to select which path
%
%Returns:
%   q_tar (4x1 array): the target quaternion
    
    switch(a)
        case 1
            %0 -> PI/2 AROUND XZ WITH 10 STEPS
            N = 10;
            qm_1 = quatconstruct([0, 0, 0], 'rotation', 'matlab');
            qm_2 = quatconstruct([pi/2, 0, pi/2], 'rotation', 'matlab');
            qms = slerp(qm_1, qm_2, linspace(0, 1, N));
            i = floor(t * N/1000) + 1;
            if i <= N
                qm_tar = qms(i);
            else
                qm_tar = qms(N);
            end
        case 2
            %0 -> PI/4 AROUND YZ WITH 10 STEPS
            N = 10;
            qm_1 = quatconstruct([0, 0, 0], 'rotation', 'matlab');
            qm_2 = quatconstruct([0, pi/4, pi/4], 'rotation', 'matlab');
            qms = slerp(qm_1, qm_2, linspace(0, 1, N));
            i = floor(t * N/1000) + 1;
            if i <= N
                qm_tar = qms(i);
            else
                qm_tar = qms(N);
            end
    end
    q_tar = quatconvert(qm_tar, 'matlab', 'simulink');