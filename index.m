function perm = index(position)
    n_arr = [1 5];
    r_arr = [5 -10];
    perm = index_sigmoid(position, n_arr, r_arr);
%     if norm(position) > r_arr(1)
%         perm = n_arr(1);
%     elseif norm(position) > r_arr(2)
%         perm = n_arr(2);
%     end
end