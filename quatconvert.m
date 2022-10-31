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
%   quaternion if optype is 'matlab', 4x1 array if optype is 'simulink' or 1x4 array if
%   optype is 'aerospace'

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