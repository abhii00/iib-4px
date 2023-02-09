function tau = lsdecomp(tau_tot, D)
%function to decompose overall torque into required reaction wheels torques
%
%Arguments:
%   D (nx3 array): the directions of the n reaction wheels
%   tau_tot (3x1 array): the total control torque
%Returns:
%   tau (nx1 array): the magnitude of the reaction wheel torque

%recast to Ax=b
A = D.';
b = tau_tot.';

%solve for x
%x = mldivide(A, b);
x = pinv(A)*b;

%recast to origin
tau = x.';