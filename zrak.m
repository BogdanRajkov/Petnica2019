function [rays, intensity] = zrak(intensity, position, kvector, n_arr, r_arr)
    error = 2^-25;
    max_position = 10;
    gamma = 5e-2;

%     fprintf('%.3d %.3d\n', position);
    rays = [];
%     position_arr = zeros(1e6, 2);
%     kvector_arr = zeros(1e6, 2);
%     t = 1;
%     position_arr(t,:) = position;
%     kvector_arr(t,:) = kvector;
    
    while norm(position) < max_position
        n1 = index(position, n_arr, r_arr);
        l = 0;
        h = .1;
        while h - l > error
            m = (l + h) / 2;
            if index(position + m * kvector, n_arr, r_arr) == n1
                l = m;
            else
                h = m;
            end
        end
        position = position + h * kvector;
        if n1 ~= 1
            intensity = intensity * exp(-(h*norm(kvector)*gamma));
        end
        
        if index(position, n_arr, r_arr) ~= n1
            n2 = index(position, n_arr, r_arr);
            k1 = norm(kvector);
            er = position / norm(position);
            et = [er(2) -er(1)];
            kt = dot(kvector, et);
            kr = dot(kvector, er);
            k2 = (n2/n1)*k1;
            if k2 < kt
                position = position - (h-l) * kvector;
                kvector = -kr * er + kt * et;
            else
                cosOi = abs(dot(kvector / norm(kvector), er));
                kvector = sign(kr) * sqrt(k2^2 - kt^2) * er + kt * et;
                cosOt = abs(dot(kvector / norm(kvector), er));
                Rs = ((n1*cosOi-n2*cosOt)/(n1*cosOi+n2*cosOt))^2;
                Rp = ((n1*cosOt-n2*cosOi)/(n1*cosOt+n2*cosOi))^2;
                rays = cat(3, rays, [[Rs Rp] .* intensity; position - (h-l) * kvector; -kr * er + kt *et]');
                intensity = [1-Rs 1-Rp] .* intensity;
            end
        end
        
        if sum(intensity) < .01
            return;
        end
%         t = t + 1; 
%         position_arr(t,:) = position;
%         kvector_arr(t,:) = kvector;
    end
    hold on;
%     plot(position_arr(1:t, 1), position_arr(1:t, 2));
%     plot(position_arr(1:t, 1), position_arr(1:t, 2));
%     xlim([-5 5]);
%     ylim([-5 5]);
end