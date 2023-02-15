%% create MPC controller object with sample time
mpc1 = mpc(plant_C, 1);
%% specify prediction horizon
mpc1.PredictionHorizon = 20;
%% specify control horizon
mpc1.ControlHorizon = 4;
%% specify nominal values for inputs and outputs
mpc1.Model.Nominal.U = [0;0;0;0;0;0;0;0;0];
mpc1.Model.Nominal.Y = [1;0;0;0;1;0;0;0;1];
%% specify constraints for OV
mpc1.OV(1).Min = -1;
mpc1.OV(1).Max = 1;
mpc1.OV(2).Min = -1;
mpc1.OV(2).Max = 1;
mpc1.OV(3).Min = -1;
mpc1.OV(3).Max = 1;
mpc1.OV(4).Min = -1;
mpc1.OV(4).Max = 1;
mpc1.OV(5).Min = -1;
mpc1.OV(5).Max = 1;
mpc1.OV(6).Min = -1;
mpc1.OV(6).Max = 1;
mpc1.OV(7).Min = -1;
mpc1.OV(7).Max = 1;
mpc1.OV(8).Min = -1;
mpc1.OV(8).Max = 1;
mpc1.OV(9).Min = -1;
mpc1.OV(9).Max = 1;
%% specify weights
mpc1.Weights.MV = [0 0 0 0 0 0 0 0 0];
mpc1.Weights.MVRate = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];
mpc1.Weights.OV = [1 1 1 1 1 1 1 1 1];
mpc1.Weights.ECR = 100000;
%% specify simulation options
options = mpcsimopt();
options.RefLookAhead = 'off';
options.MDLookAhead = 'off';
options.Constraints = 'on';
options.OpenLoop = 'off';
%% run simulation
sim(mpc1, 101, mpc1_RefSignal, mpc1_MDSignal, options);
