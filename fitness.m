function out = fitness(n_arr, r_arr)
%     tic;
    
    n_arr = cat(2, 1, n_arr);
    r_arr = cat(2, r_arr, 0);
    start_par = [];
    for i = 0.1:0.01:5
        start_par = cat(3, start_par, [1 1; -5 i; 1 0]);
    end
    len = size(start_par, 3);
    out = 0;
    scale_factor = 2 * len;

    while len > 0
       intensity = start_par(1, :, len);
       position = start_par(2, :, len); 
       kvector = start_par(3, :, len);
       start_par(:, :, end) = [];
       len = len - 1;
       if sum(intensity) < .01
           continue
       end
       [rays, ei] = zrak(intensity, position, kvector, n_arr, r_arr);
       out = out + sum(ei);
       start_par = cat(3, start_par, rays);
       if ~isequal(rays, [])
           len = len + size(rays, 3);
       end
    end
    
    out = out / scale_factor;
    
%     timeElapsed = toc;
    fprintf('out = %d\n', out);