function tau = taudecomp(tau_tot, D, q_acc)
%function to decompose overall torque into required reaction wheels torques
%
%Arguments:
%   D (nx3 array): the directions of the n reaction wheels
%   q_acc (4x1 array): the current quaternion
%   tau_tot (3x1 array): the total control torque
%Returns:
%   tau (nx1 array): the magnitude of the reaction wheel torque
    
    %convert from q to qm
    qm_acc = quatconvert(q_acc, 'simulink', 'matlab');

    %rotate D using qm
    D_acc = rotatepoint(qm_acc, D);

    %recast to Ax=b
    A = D_acc.';
    b = tau_tot.';
    
    %solve for x
    x = A\b;
    
    %recast to original
    tau = x.';
end