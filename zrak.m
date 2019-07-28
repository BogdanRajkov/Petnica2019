function [rays] = zrak(intensity, position, kvector)
    fprintf('%d %d\n', position);
    rays = zeros(2, 3, 2);
    start_kvector = kvector;
    n1 = index(position);
    position_arr = zeros(1e6, 2);
    kvector_arr = zeros(1e6, 2);
    t = 1;
    position_arr(t,:) = position;
    kvector_arr(t,:) = kvector;
    
    while norm(position) > .1 && norm(position) < 10 && index(position) < 4.99
%         l = 0;
%         h = 1;
%         while h - l > 1e-4
%             m = (l + h) / 2;
%             if abs(index(position) - index(position + m * kvector)) < 1e-4
%                 l = m;
%             else
%                 h = m;
%             end
%         end
%         position = position + l * kvector;
        
        t = t + 1; 
        [intensity, position, kvector] = propagate(intensity, position, kvector, 1e-4);
        position_arr(t,:) = position;
        kvector_arr(t,:) = kvector;
    end
    hold on;
    plot(position_arr(1:t, 1), position_arr(1:t, 2));
%     plot(position_arr(1:t, 1), position_arr(1:t, 2));
    if imag(position) ~= 0
        fprintf('fuck');
    end
    if ~isequal(n1, index(position))
        n2 = index(position);
        cosOi = dot(-start_kvector/norm(start_kvector), position/norm(position));
        cosOt = dot(-kvector/norm(kvector), position/norm(position));
        rays = [sqrt(1-cosOt^2), n1/n2*sqrt(1-cosOi^2)];
    end
%         Rs = ((n1*cosOi-n2*cosOt)/(n1*cosOi+n2*cosOt))^2;
%         Rp = ((n1*cosOt-n2*cosOi)/(n1*cosOt+n2*cosOi))^2;
%         rays(:, 1, 1) = [Rs 0; 0 Rp] * intensity';
%         rays(:, 2, 1) = position';
%         rays(:, 3, 1) = start_kvector' - 2*dot(start_kvector, position/norm(position))*position'/norm(position);
%         rays(:, 1, 2) = [1-Rs 0; 0 1-Rp] * intensity';
%         rays(:, 2, 2) = position';
%         rays(:, 3, 2) = kvector';
%     elseif norm(position) >= 7
%         rays = sum(intensity);
%     end
end