function out = fitness(n_arr, r_arr)
%     tic;
    
    n_arr = cat(2, 1, n_arr);
    if ~(all(n_arr <= 4) && all(n_arr >= 1))
        fprintf('Indices out of bounds\n');
        out = 1;
        return;
    end
    
    
    r_arr = cat(2, 5, r_arr, 0);
    
    [ ~, ix ] = min(abs(r_arr - exp(.5)));
    if r_arr(ix) < exp(.5)
        ix = ix-1;
    end
    
    if ~all((n_arr(2:ix) - n_arr(1:ix-1)) > 0)
        fprintf('Indices non-increasing\n')
    end
    
    if r_arr(2) > 5
        fprintf('Sphere too big\n')
        out = 1;
        return;
    end
    
    start_par = [];
    for i = 0.1:0.05:5
        start_par = cat(3, start_par, [1 1; -5 i; 1 0]');
    end
    len = size(start_par, 3);
    out = 0;
    scale_factor = 2 * len;

    while len > 0
       intensity = start_par(:, 1, len);
       position = start_par(:, 2, len); 
       kvector = start_par(:, 3, len);
       start_par = start_par(:, :, 1:end-1);
       len = len - 1;
       if sum(intensity) < .01
           continue
       end
       [rays, ei] = zrak(intensity', position', kvector', n_arr, r_arr);
       out = out + sum(ei);
       start_par = cat(3, start_par, rays);
       if ~isequal(rays, [])
           len = len + size(rays, 3);
       end
    end
    
    out = out / scale_factor;
    
%     timeElapsed = toc;
%     fprintf('out = %d\n', out);