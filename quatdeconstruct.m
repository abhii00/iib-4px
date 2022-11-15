function vec = quatdeconstruct(Q, iptype, optype)
%converts quaternion to standard vector
%
%Arguments:
%   Q (quaternion or 1x4 array or 4x1 array): the quaternion to be converted
%   iptype (string): the input type of the quaternion from 'matlab', 'simulink' or 'aerospace'
%   optype (string): the output type of the vector from 'cartesian' 
%
%Returns:
%   3x1 vector if optype is 'cartesian'

    Qm = quatconvert(Q, iptype, 'matlab');
    switch optype
        case 'cartesian'
            Qa = compact(Qm);
            vec = Qa(2:4);
    end