function [ perm ] = permittivity_sigmoid(position, n, r)
    k = size(n);
    k = k(2);
    A = eye(k);
    B = eye(k-1);
    B = cat(2, B, zeros(k-1, 1));
    B = cat(1, zeros(1, k), B);
    diff = n*(A-B);
    
    x = norm(position);
    sigm = sigmf(-r, [20 -x]);
    
    perm = sum(diff.*sigm);
end