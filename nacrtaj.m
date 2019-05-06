addpath('./ravan');

start_rays = [ones(1, 5) * -5; -4 : 2 : 4]';
start_kvector = repmat([1 1], 5, 1);
len = size(start_rays);
len = len(1);
setup();

hold on;
for it = 1:len
   position = start_rays(it,:);
   kvector = start_kvector(it,:);
   position_arr = zeros(1e6, 2);
   kvector_arr = zeros(1e6, 2);
   position_arr(1,:)
   t = 1;
   while abs(position(1)) <= 5
       [position, kvector] = propagate(position, kvector);
       position_arr(t,:) = position;
       kvector_arr(t,:) = kvector;
       t = t + 1;
   end
   plot(position_arr(1:t-1,1), position_arr(1:t-1,2));
end
hold off;

