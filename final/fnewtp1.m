function [f,D] = fnewtp1(x,a)
%  Function used by the N-variable Newton's method
%  Inputs
%    x     State vector [x y]
%    a     Parameters [k1 k2 L D]
%  Outputs
%    f     Lorenz model r.h.s. [dx/dt dy/dt]
%    D     Jacobian matrix, D(i,j) = df(j)/dx(i)
k1 = a(1);
k2 = a(2);
L = a(3);
d = a(4);
m = a(5);
g = a(6);

% Evaluate f(i)
f(1) = -( a(1)*x(1) - a(1)*L*x(1)/sqrt( x(1)^2 + x(2)^2 )...
 + a(2)*(x(1)-d) - a(2)*L*(x(1)-d)/sqrt( (x(1)-d)^2 + x(2)^2 ));

f(2) = -( a(1)*x(2) - a(1)*L*x(2)/sqrt( x(1)^2 + x(2)^2 )...
 + a(2)*x(2) - a(2)*L*x(2)/sqrt( (x(1)-d)^2 + x(2)^2 ) - m*g);


% Evaluate D(i,j)
D(1,1) = -( k1 - (L*k1*x(2)^2)/((x(1)^2 + x(2)^2)^(3/2))...
 + k2 - (L*k2*x(2)^2)/(((d-x(1))^2 + x(2)^2)^(3/2)) ); %df(1)/dx

D(2,1) = -( (k1*L*x(1)*x(2))/((x(1)^2 + x(2)^2)^(3/2))...
 + (k2*L*x(2)*(x(1)-d))/( ( (d-x(1))^2 + x(2)^2 )^(3/2) ) ); % df(1)/dy

D(1,2) = -( (k1*L*x(1)*x(2))/((x(1)^2 + x(2)^2)^(3/2))...
 + (k2*L*x(2)*(x(1)-d))/(((d-x(1))^2 + x(2)^2)^(3/2)) ); % df(2)/dx

D(2,2) = -( k1 - (k1*L*(x(1)^2))/((x(1)^2 + x(2)^2)^(3/2))...
 + k2 - (k2*L*((d-x(1))^2))/( ( (d-x(1))^2 + x(2)^2 )^(3/2) ) ); % df(2)/dy
return;
