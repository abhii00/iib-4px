es = zeros(size(ts));
for j = 1:length(ts)
    %convert from q to qm
    qm_acc = quatconvert(qs_acc(:, :, j), 'simulink', 'matlab');
    qm_tar = quatconvert(qs_tar(:, :, j), 'simulink', 'matlab');

    es(j) = dist(qm_tar, qm_acc);
end

Z = 4e-4;
subplot(3, 1, 1);
plot(ts, es.^2);
subplot(3, 1, 2);
plot(ts, Z*dot(ws_rw, ws_rw, 2))
subplot(3, 1, 3);
plot(ts, es.^2 + Z*dot(ws_rw, ws_rw, 2))