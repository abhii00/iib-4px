%DEFINITION
%Q = a + bi + cj + dk
%q = Q/|Q|
%V = rotation vector for Q with magnitude theta, axis p

%matlab: object, 1x4
Qm = quaternion(a, b, c, d);
Qm = quaternion([a, b, c, d]);
%simulink: 4x1
Q = [a; b; c; d];
%aerospace toolbox: 1x4
Qa = [a, b, c, d];

%CONVERSION
%matlab -> simulink
Q = compact(Qm).';
%simulink -> matlab
Qm = quaternion(Q.');
%matlab -> aerospace
Qa = compact(Qm);
%aerospace -> matlab
Qm = quaternion(Qa);
%simulink -> aerospace
Qa = Q.';
%aerospace -> simulink
Q = Qa.';