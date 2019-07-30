function out = index(position, n_arr, r_arr)
    i = 1;
    x = norm(position);
    while i > 0
        if x >= r_arr(i)
            out = n_arr(i);
            break
        end
        i = i + 1;
    end
end