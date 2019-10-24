k_arr = [10, 9, 11, 8, 12, 7, 13, 14, 15, 16];
n_ub = 3;

for i = 1:length(k_arr)
    k = k_arr(i);
    r_start = 5*(k-1)/k:-5/k:5/k;
    n_start = (k+n_ub)/(k+1):(n_ub-1)/(k+1):(n_ub*k+1)/(k+1);

    neldermead_n(k, n_start', r_start);
end