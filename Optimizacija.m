
n=2;
x0 = [2.5 5 5 2.5]';
lb = cat(1, ones(n, 1), zeros(n, 1));
ub = cat(1, 10 * ones(n, 1), Inf * ones(n, 1));
A = -eye(n-1, n-1);
A = cat(1, A, zeros(1, n-1));
A = cat(2, zeros(n, 1), A);
A = A + eye(n, n);
A(n, n) = 0;
A = cat(1, A, zeros(n, n));
A = cat(2, A, zeros(2*n, n));
b = zeros(2*n, 1);
Aeq = [];
beq = [];

[x_min, fval] = fmincon(@(x) fitness(x(1:2)', x(3:4)'), ...
                x0, A, b, Aeq, beq, lb, ub);
            
save('optimizacija.mat');            
    
% for i=1:n
%     ub(i)=(n-i+2)^2; % gornja granica za epsilon
%     lb(i)=(n-i+1)^2; % donja granica za epsilon
%     ub(n+i)=i*5/n; % gornja granica za r
%     lb(n+i)=ub(n+i)-5/n; % donja granica za r
%     x0(i)=(ub(i)+lb(i))/2;
%     x0(n+i)=(ub(n+i)+lb(n+i))/2; % n epsilona, pa n r-ova
% end