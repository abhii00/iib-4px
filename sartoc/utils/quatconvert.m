function Q_o = quatconvert(Q_i, iptype, optype)
%converts quaternion between two types
%
%Arguments:
%   Q_i (quaternion or 1x4 array or 4x1 array): the quaternion to be
%   converted 
%   iptype (string): the input type of the quaternion from 'matlab',
%   'simulink' or 'aerospace' 
%   optype (string): the output type of the quaternion from 'matlab',
%   'simulink' or 'aerospace' 
%
%Returns:
%   quaternion if optype is 'matlab', 4x1 array if optype is 'simulink' or
%   1x4 array if optype is 'aerospace' 
%
%Definitions:
%   Q = a + bi + cj + dk
%   q = Q/|Q|
%   Note: qd and qdd represent rate of change of normalized quaternion rather
%   than being normalized themselves
%
%   Matlab Definition: object, 1x4: Qm = quaternion(a, b, c, d) or
%   quaternion([a, b, c, d]) 
%   Simulink Definition: 4x1: Q = [a; b; c; d]
%   Aerospace Toolbox Definition: 1x4: Qa = [a, b, c, d]
%
%Conversions:
%   matlab -> simulink: Q = compact(Qm).'
%   simulink -> matlab: Qm = quaternion(Q.')
%   matlab -> aerospace: Qa = compact(Qm)
%   aerospace -> matlab: Qm = quaternion(Qa)
%   simulink -> aerospace: Qa = Q.'
%   aerospace -> simulink: Q = Qa.'

    %convert to matlab format
    switch iptype
        case 'matlab'
            Qm = Q_i;
        case 'simulink'
            Qm = quaternion(Q_i.');
        case 'aerospace'
            Qm = quaternion(Q_i);
    end
    %convert from matlab format
    switch optype
        case 'matlab'
            Q_o = Qm;
        case 'simulink'
            Q_o = compact(Qm).';
        case 'aerospace'
            Q_o = compact(Qm);
    end
end