n_limit = [1 3];
r_limit = [0 5];
spread = [2.9 0.1; 2 1; 1 2; 0.1 2.9]'/3;
n_start = n_limit * spread;
r_start = r_limit * spread;
x = [];

for n1 = 1:4
    for n2 = 1:4
        for r1 = 1:4
            pos = [n1 n2 r1];
            for i = 2:10
                if i == 2
                    x = neldermead(2, [n_start(n1) n_start(n2) r_start(r1)]', pos);
                else
                    n_arr = x(1:i-1);
                    r_arr = x(i:2*i-3);
                    diff = cat(1, 5, r_arr) - cat(1, r_arr, 0);
                    [~, idx] = max(diff);
                    n_arr = cat(1, n_arr(1:idx), n_arr(idx), n_arr(idx+1:end));
                    if idx == 1
                        r_arr = cat(1, (5+r_arr(idx))/2, r_arr);
                    elseif r_arr(idx-1) == r_arr(end)
                        r_arr = cat(1, r_arr, r_arr(idx-1)/2);
                    else
                        r_arr = cat(1, r_arr(1:idx-1), (r_arr(idx-1)+r_arr(idx))/2, r_arr(idx:end));
                    end
                    x = cat(1, n_arr, r_arr);
                    if size(x, 1) ~= 2*i-1
                        fprintf('fuck');
                    end
                    x = neldermead(i, x, pos);
                end
            end
        end
    end
end