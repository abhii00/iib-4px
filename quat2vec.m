function vec = quat2vec(Q, iptype, optype)
    Qm = quatconvert(Q, iptype, 'matlab');
    switch optype
        case 'cartesian'
            Qa = compact(Qm);
            vec = Qa(2:4);
    end