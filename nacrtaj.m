inputID = fopen('input.txt', 'r');
name = fgetl(inputID);
addpath(strcat('./', name));
temp = fscanf(inputID, ' %d %d;', [2 Inf]);
fclose(inputID);
len = size(temp);
temp = reshape(temp, [2 len(2)/2 2]);
start_rays = temp(:, :, 1)';
start_kvector = temp(:, :, 2)';

len = size(start_rays);
len = len(1);
setup();

tic;

hold on;
for it = 1:len
   position = start_rays(it,:);
   kvector = start_kvector(it,:);
   position_arr = zeros(1e6, 2);
   kvector_arr = zeros(1e6, 2);
   position_arr(1,:)
   t = 1;
   while norm(position) > 1 && position(1)<3 && position(2)<7
       [position, kvector] = propagate(position, kvector);
       position_arr(t,:) = position;
       kvector_arr(t,:) = kvector;
       t = t + 1;
   end
   plot(position_arr(1:t-1,1), position_arr(1:t-1,2));
end
hold off;
saveas(gcf, strcat(datestr(now, 'yyyy-mm-dd HH:MM'), '.png'));

timeElapsed = toc;

%%
outputID = fopen(strcat(datestr(now, 'yyyy-mm-dd HH:MM'), '.log'), 'w');
fprintf(outputID, '---INPUT---\r\n\r\n');
fprintf(outputID, strcat(name, '\r\n'));
fprintf(outputID, ' %d %d;', start_rays');
fprintf(outputID, '\r\n');
fprintf(outputID, ' %d %d;', start_kvector');
fprintf(outputID, '\r\n\r\n---OUTPUT---\r\n\r\n');
fprintf(outputID, strcat('\r\nDuration: ', num2str(timeElapsed), ' s\r\n'));
fclose(outputID);