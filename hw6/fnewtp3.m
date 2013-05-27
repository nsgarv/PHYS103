function [f,D] = fnewtp3(x)
%  Function used by the N-variable Newton's method
%  Inputs
%    x     State vector [x y]
%  Outputs
%    f     Lorenz model r.h.s. [dx/dt dy/dt]
%    D     Jacobian matrix, D(i,j) = df(j)/dx(i)

% Evaluate f(i)
f(1) = x(1)^2+x(1)*x(2)-10;
f(2) = x(2)+3*x(1)*x(2)^2-57;

% Evaluate D(i,j)
D(1,1) = 2*x(1)+x(2);   % df(1)/dx(1)
D(1,2) = 3*x(2)^2;      % df(2)/dx(1)
D(2,1) = x(1);          % df(1)/dx(2)
D(2,2) = 1+6*x(1)*x(2); % df(2)/dx(2)
return;
