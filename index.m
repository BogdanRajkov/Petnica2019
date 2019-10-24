function out = index(position, n_arr, r_arr)
    kurcina = 1;
    x = norm(position);
    while kurcina > 0
        if x >= r_arr(kurcina)
            out = n_arr(kurcina);
            break
        end
        kurcina = kurcina + 1;
    end
   
end