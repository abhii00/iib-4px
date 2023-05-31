Real-time Optimal Control of Spacecraft Attitude
================================================

Abhijit Pandit

File Structure
--------------
<pre>
*- dev/
*- pen/
*- results/
- sartoc/
    - controls/
        - evaluatecost.m <i>Evaluates cost funciton</i>
        - mpcpd.m <i>MPC to generate PD gains</i>
        - pdcontroller.m <i>PD controller for stabilisation</I>
        - predictcost.m <i>Predicts cost</i>
        - prepforcost.m <i>Gets relevant data for cost</i>
        - refpath.m <i>Creates reference trajectory</i>
        - taudecomp.m <i>Decomposes control torque to reaction wheels</i>
    - utils/
        *- path/
        - prep/
            - prepaux.m <i>Prepares and saves auxiliary variables - thetas</i>
            - prepgain.m <i>Prepares and saves control parameters - ks, lambdas</i>
            - prepinfo.m <i>Prepares and saves information</i>
            - prepmain.m <i>Prepares and saves main data - trajectory, target trajectory, ws_rw, taus</i>
        - quat/
            - quatconstruct.m <i>Constructs quaternion from direction or rotation vector</i>
            - quatconvert.m <i>Converts quaternion between matlab, simulink and aerospace types.</i>
        - subsys/
            - mag.slx <i>Subsystem for magnitude.</i>
            - qabssens.slx <i>Subsystem for abs q sensor.</i>
            - thetarelsens.slx <i>Subsystem for abs theta sensor.</i>
            - wabssens.slx <i>Susbsystem for abs w sensor.</i>
            - wrelsens.slx <i>Subsystem for rel w sensor.</i>
        - prep.m <i>Wrapper for preparing and saving data</i>
        - prepvisualise.m <i>Wrapper for preparing, saving and visualising data</i>
        - simmpcpd.m <i>Wrapped for simulation of mpc-pd</i>
        - simpd.m <i>Wrapper for simulation of pd</i>
        - visualise.m <i>Wrapper for visualising data</i>
    *- visualiser-js/
    - visualiser-matlab/
        - visualiseaux.m <i>Plots auxiliary variables - thetas</i>
        - visualisecont.m <i>Plots control parameters - ws_rw, taus, ks, lambdas</i>
        - visualiseenv.m <i>Visualises 3D rotation sphere</i>
        - visualiseperf.m <i>Plots cost</i>
        - visualisetraj.m <i>Visualises 3D trajectories</i>
- .gitignore
</pre>