function perm = permittivity(position)
    n_arr = [1 5];
    r_arr = [5 -10];
    perm = permittivity_sigmoid(position, n_arr, r_arr);
end