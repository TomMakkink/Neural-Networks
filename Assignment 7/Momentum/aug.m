function pa = aug(p)
% appends a last row of 1s to the matrix p
pa = [p;ones(1,size(p,2))];