%file to prepare output, after simulation run
[ts, qs_acc, dqs_acc, ddqs_acc, qs_tar] = prepmaindata(out, fn);
if exist('aux','var') == 1
    if aux
        [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b] = prepauxdata(out, fn);
    end
end
prepinfodata(fn);
