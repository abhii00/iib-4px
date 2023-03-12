%shortcut file to prepare output, after simulation run

%create filename string and directory
filename = input('File Name:', 's');
info = input('Information for this test case: ', "s");
mkdir(['./results/' filename '/']);
fn = ['./results/' filename '/' filename];

%prep info
prepinfo(info, fn);

%prep main data
[ts, qs_acc, dqs_acc, ddqs_acc, qs_tar, ws_rw, taus] = prepmain(out, fn);

%prep gain data
[tgs, ks, lambdas] = prepgain(out, fn);

%prep aux data
if exist('aux','var') == 1
    if aux
        [ts, thetas_sp1a, thetas_sp1b, thetas_sp2a, thetas_sp2b] = prepaux(out, fn);
    end
end