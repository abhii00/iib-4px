function tau_tot = pdcontroller(q_tar, q_acc, dq_acc, k, lambda, P)
%function to implement simple PD control law
%
%Arguments:
%   q_tar (4x1 array): target quaternion
%   q_acc (4x1 array): actual quaternion
%   dq_acc (4x1 array): actual quaternion derivative
%   k (1xn array): the vector of proportional gains for each pointing direction
%   lambda (1xn array): the vector of derivative gains for each pointing direction
%   P (3xn array): the pointing directions
%
%Returns:
%   tau_tot (3x1 array): the total torque required to correct the error

    %convert from q to qm
    qm_acc = quatconvert(q_acc, 'simulink', 'matlab');
    qm_tar = quatconvert(q_tar, 'simulink', 'matlab');
    dqm_acc = quatconvert(dq_acc, 'simulink', 'matlab');
    
    %iterate over all pointing directions
    mn = size(P);
    taus = zeros(mn);
    for j = 1:mn(1)
        %rotate p using qm
        p = P(j, :);
        p_acc = rotatepoint(qm_acc, p);
        p_tar = rotatepoint(qm_tar, p);

        %construct qp from p, find dqpm, convert to dp
        qp_acc = [0; p_acc.'];
        qpm_acc = quatconvert(qp_acc, 'simulink', 'matlab');
        dqpm_acc = dqm_acc*conj(qm_acc)*qpm_acc - qpm_acc*dqm_acc*conj(qm_acc);
        dqp_acc = quatconvert(dqpm_acc, 'matlab', 'simulink');
        dp_acc = dqp_acc(2:4).';
                
        %find torque for that direction
        taus(j, :) = cross(p_acc, k(j) * (p_tar - p_acc) - lambda(j) * dp_acc);
    end

    %find torque
    tau_tot = -1*sum(taus);
end