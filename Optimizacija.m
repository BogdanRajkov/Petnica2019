n=15;
lb=zeros(n,1);
ub=zeros(n,1);
x0=zeros(n,1);
for i=1:n
    ub(i)=(n-i+2)^2; % gornja granica za epsilon
    lb(i)=(n-i+1)^2; % donja granica za epsilon
%     ub(n+i)=i*5/n; % gornja granica za r
%     lb(n+i)=ub(n+i)-5/n; % donja granica za r
    x0(i)=(ub(i)+lb(i))/2;
%     x0(n+i)=(ub(n+i)+lb(n+i))/2; % n epsilona, pa n r-ova
end
Aeq=[];
beq=[];
A=[];
b=[];
%fmincon(fun, x0, A, b, Aeq, beq, lb, ub);