k_arr = [7, 10,      8, 11];

for i = 1:length(k_arr)
    k = k_arr(i);
    r_start = 5*(k-1)/k:-5/k:5/k;
    n_start = (k+3)/(k+1):2/(k+1):(3*k+1)/(k+1);

    neldermead_n(k, n_start', r_start);
end