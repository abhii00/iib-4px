%file to prepare output, after simulation run
[ts, qs_acc, qds_acc, qdds_acc, qs_tar] = prepmaindata(out, fn);
[ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b] = prepauxdata(out, fn);
prepinfodata(fn);
