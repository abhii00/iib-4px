function visualise(Qs_sta, Qs_tar, tout, p, offset)
%helper function to visualise the results of the simulation
%
%Arguments:
%   Qs_sta (array): the quaternion array for the states
%   Qs_tar (array): the quaternion array for the target
%   tout (array): the time array
%   p (3x1 array): the axis to point, defaults to [1, 0, 0]
%   offset (float): the offset for the points, defaults to 1.05
%   
%Returns:
%   None

    arguments
        Qs_sta
        Qs_tar
        tout
        p = [1, 0, 0]
        offset = 1.05
    end

    figure;
    visualiseconv(Qs_sta, Qs_tar, tout, p);

    figure;
    visualisetraj(Qs_sta, Qs_tar, tout, p, offset);