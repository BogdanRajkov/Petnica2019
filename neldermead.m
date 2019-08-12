tic;

n = 2;
x0 = [9 1 2]';
options = optimset('fminsearch');
options = optimset(options, 'Display', 'iter', ...
                   'PlotFcns', @optimplotfval, ...
                   'TolFun', 1e-2, 'TolX', 2e-3);
[x, fval, exitflag, output] = fminsearch(@(x) fitness(x(1:n)', x(n+1:2*n-1)'), x0, options);
save('neldermead.mat');

timeElapsed = toc;

%%

outputID = fopen(strcat(char(39), 'rezultati', char(39), '/fminsearch', datestr(now, ' yyyy-mm-dd HH-MM'), '.log'), 'w');
fprintf(outputID, '---INPUT---\r\n\r\n');
fprintf(outputID, 'N# of layers: %d\r\n', n);
fprintf(outputID, 'Layer refractive indices and thicknesses');
fprintf(outputID, ' %d,', x0);
fprintf(outputID, '\r\n\r\n---OUTPUT---\r\n\r\nOptimal x:');
fprintf(outputID, ' %d,', x);
fprintf(outputID, '\r\nFunction minimum: %d\r\n', fval);
fprintf(outputID, 'Did the search converge: %d\r\n', exitflag);
fprintf(outputID, strcat('\r\nDuration: ', num2str(timeElapsed), ' s\r\n'));
fclose(outputID);