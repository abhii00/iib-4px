function q_tar = refpath(t, a)
%function to provide a reference path
%
%Arguments:
%   t (float): parameter, usually time, to select point in path
%   a (int): parameter to select which path
%
%Returns:
%   q_tar (4x1 array): the target quaternion

    if (a == 1)
        N = 10;
        qm_1 = quatconstruct([0, 0, 0], 'rotation', 'matlab');
        qm_2 = quatconstruct([0, 0, pi/2], 'rotation', 'matlab');
        qms = slerp(qm_1, qm_2, linspace(0, 1, N));
        qm_tar = qms(floor(t * N/1000) + 1);
    end
    q_tar = quatconvert(qm_tar, 'matlab', 'simulink');