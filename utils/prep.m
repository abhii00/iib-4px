%file to prepare output, after simulation run
[ts, qs_acc, qds_acc, qdds_acc, qs_tar] = prepmaindata(out, fn);
[ts, qs_sp1a, qs_sp1b, qs_sp2a, qs_sp2b] = prepauxdata(out, fn);
prepinfodata(fn);
