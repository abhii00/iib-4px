model = 'cube0_mpc_tp_ls';
io(1) = linio('cube0_mpc_tp_ls/MPC',1,'input');
io(2) = linio('cube0_mpc_tp_ls/preconvacc',1,'openoutput');
%op(1, :) = [0, 0, 0];
%op(2, :) = [0.9981 0 0.043606 0.043606];
linsys1 = linearize(model,io);