function tau_tot = simpcontlaw(q_tar, q_acc, qd_acc, ks, lambdas, ps)
%function to implement simple control law
%
%Arguments:
%   q_tar (4x1 array): target quaternion
%   q_acc (4x1 array): actual quaternion
%   qd_acc (4x1 array): actual quaternion derivative
%   ks (1xn array): the proportional gain for each pointing direction
%   lambdas (1xn array): the derivative gain for each pointing direction
%   ps (3xn array): the pointing directions
%
%Returns:
%   tau_tot (3x1 array): the total torque required to correct the error

    %convert from q to qm
    qm_acc = quatconvert(q_acc, 'simulink', 'matlab');
    qm_tar = quatconvert(q_tar, 'simulink', 'matlab');
    qmd_acc = quatconvert(qd_acc, 'simulink', 'matlab');
    
    %iterate over all pointing directions
    mn = size(ps);
    taus = zeros(mn);
    for j = 1:mn(1)
        %rotate p using qm
        p = ps(j, :);
        p_acc = rotatepoint(qm_acc, p);
        p_tar = rotatepoint(qm_tar, p);

        %find w_acc
        qwm_acc = 2*qmd_acc*conj(qm_acc);
        qw_acc = quatconvert(qwm_acc, 'matlab', 'simulink');
        w_acc = qw_acc(2:4);
        pd_acc = cross(w_acc, p_acc); 
                
        %find torque for that direction
        taus(j, :) = cross(p_acc, ks(j) * (p_tar - p_acc) - lambdas(j) * pd_acc);
    end

    %find torque
    tau_tot = -1*sum(taus);