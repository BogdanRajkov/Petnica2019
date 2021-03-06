function x = neldermead(k, x0, pos)
tic;

% k = 3;
% x0 = [1.3607 2.1164 2.7228 3.8617 2.3561]';
options = optimset('fminsearch');
options = optimset(options, 'Display', 'iter', ...
                   'PlotFcns', @optimplotfval, ...
                   'TolFun', 1e-2, 'TolX', 2e-3);
[x, fval, exitflag, ~] = fminsearch(@(x) fitness(x(1:k)', x(k+1:2*k-1)'), x0, options);
x = x(1:k);
save('neldermead.mat');

timeElapsed = toc;

%%

outputID = fopen(strcat(char(39), 'rezultati', char(39), '/fminsearch_iter/', mat2str(pos), ' ', num2str(k), '.log'), 'w');
fprintf(outputID, '---INPUT---\r\n\r\n');
fprintf(outputID, 'n# of layers: %d\r\n', k);
fprintf(outputID, '\r\n\r\n---OUTPUT---\r\n\r\nOptimal x:');
fprintf(outputID, ' %d,', x);
fprintf(outputID, '\r\nFunction minimum: %d\r\n', fval);
fprintf(outputID, 'Did the search converge: %d\r\n', exitflag);
fprintf(outputID, strcat('\r\nDuration: ', num2str(timeElapsed), ' s\r\n'));
fclose(outputID);
end