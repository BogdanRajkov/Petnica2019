function [rays] = zrak(intensity, position, kvector)
    rays = zeros(2, 3, 2);
    start_kvector = kvector;
    n1 = sqrt(prod(permittivity(position)));
    position_arr = zeros(1e6, 2);
    kvector_arr = zeros(1e6, 2);
    t = 1;
    position_arr(t,:) = position;
    kvector_arr(t,:) = kvector;
    
    l = 0;
    h = 10;
    while h - l > 1e-3
        m = (l + h) / 2;
        if isequal(permittivity(position), permittivity(position + m * kvector))
            l = m;
        else
            h = m;
        end
    end
    position = position + l * kvector;
    
    while norm(position) > .1 && norm(position) < 7 && isequal(n1, sqrt(prod(permittivity(position))))
        t = t + 1; 
        [intensity, position, kvector] = propagate(intensity, position, kvector);
        position_arr(t,:) = position;
        kvector_arr(t,:) = kvector;
    end
    hold on;
    plot(position_arr(1:t, 1), position_arr(1:t, 2));
    if ~isequal(n1, sqrt(prod(permittivity(position))))
        n2 = sqrt(prod(permittivity(position)));
        cosOi = dot(-start_kvector/norm(start_kvector), position/norm(position));
        cosOt = dot(-kvector/norm(kvector), position/norm(position));
        Rs = ((n1*cosOi-n2*cosOt)/(n1*cosOi+n2*cosOt))^2;
        Rp = ((n1*cosOt-n2*cosOi)/(n1*cosOt+n2*cosOi))^2;
        rays(:, 1, 1) = [Rs 0; 0 Rp] * intensity';
        rays(:, 2, 1) = position';
        rays(:, 3, 1) = start_kvector' - 2*dot(start_kvector, position/norm(position))*position'/norm(position);
        rays(:, 1, 2) = [1-Rs 0; 0 1-Rp] * intensity';
        rays(:, 2, 2) = position';
        rays(:, 3, 2) = kvector';
    elseif norm(position) >= 7
        rays = sum(intensity);
    end
end