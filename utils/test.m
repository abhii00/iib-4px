p = [1, 0, 0];
k = 1;
lambda = 5;
vs = [];
taus = [];
for i=1:length(ts)
    qm_acc = quatconvert(qs_acc(:, i), 'simulink', 'matlab');
    qm_tar = quatconvert(qs_tar(:, i), 'simulink', 'matlab');
    qmd_acc = quatconvert(qds_acc(:, i), 'simulink', 'matlab');

    p_acc = rotatepoint(qm_acc, p);
    p_tar = rotatepoint(qm_tar, p);

    %find w_acc
    qwm_acc = 2*qmd_acc*conj(qm_acc);
    qw_acc = quatconvert(qwm_acc, 'matlab', 'simulink');
    w_acc = qw_acc(2:4);
    pd_acc = cross(w_acc, p_acc); 
            
    %find torque for that direction
    thetas(i) = acos(dot(p_acc, p_tar));
    vs(i, :) = w_acc;
    taus(i) = norm(cross(p_acc, k * (p_tar - p_acc) - lambda * pd_acc));
end
plot(ts, vs)
figure;
plot(ts, thetas)