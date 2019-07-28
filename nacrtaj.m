clc;

inputID = fopen('input.txt', 'r');
temp = fscanf(inputID, ' %d %d;', [2 Inf]);
fclose(inputID);
len = size(temp);
start_par = reshape(temp, [2 len(2)/3 3]);
start_par = cat(2, start_par, zeros(2, 100, 3));

len = len(2)/3;
exit_intensity = 0;
setup();

tic;

hold on;
while len > 0
   intensity = start_par(:,len,1)';
   position = start_par(:,len,2)'; 
   kvector = start_par(:,len,3)';
   len = len - 1;
   if sum(intensity) < .05
       continue
   end
   rays = zrak(intensity, position, kvector);
   if sum(size(rays)) > 2
       len = len + 1;
       start_par(:, len, :) = rays(:, :, 1);
       len = len + 1;
       start_par(:, len, :) = rays(:, :, 2);
   elseif sum(size(rays)) == 2
       exit_intensity = exit_intensity + rays;
   end
end
hold off;
saveas(gcf, strcat(char(39), 'rezultati', char(39), '/', datestr(now, 'yyyy-mm-dd HH-MM'), '.png'));

timeElapsed = toc;

%%
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