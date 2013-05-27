function [f,D] = fnewtp1(x,param)
%  Function used by the N-variable Newton's method
%  Inputs
%    x     State vector [x y]
%  Outputs
%    f     Lorenz model r.h.s. [dx/dt dy/dt]
%    D     Jacobian matrix, D(i,j) = df(j)/dx(i)
A = param(1);
B = param(2);

% Evaluate f(i)
f(1) = A + (x(1).^2)*x(2) - (B+1)*x(1);
f(2) = B*x(1) - (x(1).^2)*x(2);

% Evaluate D(i,j)
D(1,1) = 2*x(1)*x(2)-B-1;   % df(1)/dx(1)
D(1,2) = B-2*x(1)*x(2);      % df(2)/dx(1)
D(2,1) = x(1)^2;          % df(1)/dx(2)
D(2,2) = -x(1)^2; % df(2)/dx(2)
return;
