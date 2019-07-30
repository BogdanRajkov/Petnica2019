clc;

inputID = fopen('input.txt', 'r');
temp = fscanf(inputID, ' %d %d;', [2 Inf]);
fclose(inputID);
len = size(temp);
start_par = reshape(temp, [2 len(2)/3 3]);
start_par = permute(start_par, [3 1 2]);
n_arr = [1 2.5 5];
r_arr = [5 2.5 0];

len = len(2)/3;
exit_intensity = 0;
setup();

tic;

hold on;
while len > 0
   intensity = start_par(1, :, len);
   position = start_par(2, :, len); 
   kvector = start_par(3, :, len);
   start_par(:, :, end) = [];
   len = len - 1;
   if sum(intensity) < .05
       continue
   end
   [rays, ei] = zrak(intensity, position, kvector, n_arr, r_arr);
   exit_intensity = exit_intensity + sum(ei);
   start_par = cat(3, start_par, rays);
   if ~isequal(rays, [])
       len = len + size(rays, 3);
   end
end
hold off;
saveas(gcf, strcat(char(39), 'rezultati', char(39), '/', datestr(now, 'yyyy-mm-dd HH-MM'), '.png'));

timeElapsed = toc;

%%

inputID = fopen('input.txt', 'r');
temp = fscanf(inputID, ' %d %d;', [2 Inf]);
start_par = reshape(temp, [2 size(temp, 2)/3 3]);
fclose(inputID);

outputID = fopen(strcat(char(39), 'rezultati', char(39), '/', datestr(now, 'yyyy-mm-dd HH-MM'), '.log'), 'w');
fprintf(outputID, '---INPUT---\r\n\r\n');
fprintf(outputID, ' %d %d;', start_par(:,:,1));
fprintf(outputID, '\r\n');
fprintf(outputID, ' %d %d;', start_par(:,:,2));
fprintf(outputID, '\r\n');
fprintf(outputID, ' %d %d;', start_par(:,:,3));
fprintf(outputID, '\r\n');
fprintf(outputID, '\r\n---OUTPUT---\r\n\r\n');
fprintf(outputID, strcat('\r\nDuration: ', num2str(timeElapsed), ' s\r\n'));
fclose(outputID);

fprintf('done\r\n');