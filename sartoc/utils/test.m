p = [1, 0, 0];
qm_acc = quatconstruct([pi/4, 0, 0], 'rotation', 'matlab');
qm_tar = quatconstruct([pi/2, 0, 0], 'rotation', 'matlab');
dqm_acc =  quatconstruct([0, pi/100, 0], 'rotation', 'matlab');
k = 1;
lambda = 1;

p_acc = rotatepoint(qm_acc, p)
p_tar = rotatepoint(qm_tar, p);

%construct qp from p, find dqpm, convert to dp
qp_acc = [0; p_acc.'];
qpm_acc = quatconvert(qp_acc, 'simulink', 'matlab');
dqpm_acc = dqm_acc*conj(qm_acc)*qpm_acc - qpm_acc*dqm_acc*conj(qm_acc);
dqp_acc = quatconvert(dqpm_acc, 'matlab', 'simulink');
dp_acc = dqp_acc(2:4).'
        
%find torque for that direction
taus = cross(p_acc, k * (p_tar - p_acc) - lambda * dp_acc);