function Q = quatconstruct(vec, iptype, optype)
%creates a quaternion from a standard vector
%
%Arguments:
%   vec (3x1 vector): the vector to be converted
%   iptype (string): the input type of the vector from 'cartesian', 'spherical', 'rotation' 
%   optype (string): the output type of the quaternion from 'matlab', 'simulink' or 'aerospace'
%   
%
%Returns:
%   quaternion if optype is 'matlab', 4x1 array if optype is 'simulink' or
%   1x4 array if optype is 'aerospace' 

    switch iptype
        case 'cartesian'
            vec = vec/norm(vec);
            x = vec(1);
            y = vec(2);
            z = vec(3);
            Qm = quaternion(0, x, y, z);
        case 'spherical'
            theta = vec(2);
            phi = vec(3);
            Qm = quaternion(0, cos(theta)*sin(phi), sin(theta)*sin(phi), cos(phi));
        case 'rotation'
            Qm = quaternion(vec, 'rotvec');
    end
    Q = quatconvert(Qm, 'matlab', optype);