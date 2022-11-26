function q = quatconstruct(vec, iptype, optype, p)
%creates a quaternion from a standard direction or rotation vector
%
%Arguments:
%   vec (3x1 vector): the vector to be converted, either a direction or 
%   rotation vector
%   iptype (string): the input type of the vector from 'cartesian', 
%   'spherical', 'rotation' 
%   optype (string): the output type of the quaternion from 'matlab', 
%   'simulink' or 'aerospace'
%   p (3x1 vector): the vector to be pointed in direction, required if 
%   direction vector specified, defaults to [1, 0, 0]
%   
%Returns:
%   quaternion if optype is 'matlab', 4x1 array if optype is 'simulink' or
%   1x4 array if optype is 'aerospace' 
%
%Definitions:
%   v_aa, 1x4 array - axis angle with 1-3 as axis, 4 as angle
%   v_a, 1x3 array - axis angle with 1-3 as axis*angle

    arguments
        vec
        iptype
        optype
        p = [1, 0, 0]
    end

    switch iptype
        case 'cartesian'
            vec = vec/norm(vec);
            v_a = acos(dot(p, vec))*cross(p, vec)/norm(cross(p, vec)); 
            qm = quaternion(v_a, 'rotvec');
        case 'spherical'
            vec_c = [sin(vec(2))*cos(vec(3)), sin(vec(2))*sin(vec(3)), cos(vec(2))];
            v_a = acos(dot(p, vec_c))*cross(p, vec_c)/norm(cross(p, vec_c)); 
            qm = quaternion(v_a, 'rotvec');
        case 'rotation'
            qm = quaternion(vec, 'rotvec');
    end
    q = quatconvert(qm, 'matlab', optype);