
n=4;
x0 = [2 3 4 5 1.25 1.25 1.25 1.25]';
lb = cat(1, ones(n, 1), zeros(n, 1));
ub = cat(1, 10*ones(n, 1), 2 * ones(n, 1));
% A = -eye(n-1, n-1);
% A = cat(1, A, zeros(1, n-1));
% A = cat(2, zeros(n, 1), A);
% A = A + eye(n, n);
% A(n, n) = 0;
% A = cat(1, A, zeros(n, n));
% A = cat(2, A, zeros(2*n, n));
% b = zeros(2*n, 1);
% Aeq = [];
% beq = [];
A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = [];
options = optimoptions('fmincon', 'Display', 'iter', 'UseParallel', true);

[x_min, fval] = fmincon(@(x) fitness(x(1:n)', x(n+1:2*n)'), ...
                x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
            
save('optimizacija.mat'); 