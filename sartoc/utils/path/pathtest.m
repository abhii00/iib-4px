function qm = pathtest(t)
%a test function parametrising theta(t), phi(t)
%
%Arguments:
%   t (float): the parameter t
%
%Returns:
%   qm evaluated at the value t

    theta = t;
    phi = t;
    qm = quatconstruct([1, theta, phi], 'spherical', 'matlab');
end