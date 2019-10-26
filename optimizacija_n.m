k_arr = [14, 13, 12, 11, 10, 9, 8, 7];
n_ub = 4;

for i = 1:length(k_arr)
    k = k_arr(i);
    r_start = 5*(k-1)/k:-5/k:5/k;
    n_start = (k+n_ub)/(k+1):(n_ub-1)/(k+1):(n_ub*k+1)/(k+1);

    neldermead_n(k, n_start', r_start);
end