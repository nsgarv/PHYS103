function [f,D] = fnewtp1(x,a)
%  Function used by the N-variable Newton's method
%  Inputs
%    x     State vector [x y]
%    a     Parameters [k1 k2 L D]
%  Outputs
%    f     Lorenz model r.h.s. [dx/dt dy/dt]
%    D     Jacobian matrix, D(i,j) = df(j)/dx(i)
L = a(3);
d = a(4);
m = a(5);
g = a(6);

% Evaluate f(i)
%%% -K2(x-D) + 2L * (x-D)/sqrt( (x-D)^2 + y^2)) %%%
f(1) = -a(2)*(x(1)-d) + ( 2*L*(x(1)-d) )/sqrt( (x(1)-d)^2 + x(2)^2 )...
		-(-a(1)*x(1) + 2*L*x(1)/sqrt( x(1)^2 + x(2)^2 ));
%%% -k1x + 2Ly/sqrt(x^2 + y^2) %%%
%fx(2) = (-a(1)*x(1) + 2*L*x(1)/sqrt( x(1)^2 + x(2)^2 )); 
%%% -k1y + 2Ly/sqrt(x^2 + y^2) %%%
f(2) = -a(1)*x(2) + 2*L*x(2)/sqrt( x(1)^2 + x(2)^2 )...
		+ (-a(2)*x(2) + 2*L*x(2)/sqrt( (x(1)-d)^2 + x(2)^2 ))...
		- m*g;
%%% -k2y + 2Ly/sqrt((x-D)^2 + y^2) %%%
%fy(2) = (-a(2)*x(2) + 2*L*x(2)/sqrt( (x(1)-D)^2 + x(2)^2 ));

% Evaluate D(i,j)
D(1,1) =  -a(2) + 1/sqrt( (x(1) - d)^2 + x(2)^2 ) - ((x(1) - d)^2)/(( (x(1) - d)^2 + x(2)^2 )^(3/2))...
		  +a(1) -2*L/sqrt( x(1)^2 + x(2)^2 ) + (2*L*x(1)^2)/(( x(1)^2 + x(2)^2)^(3/2));    % df(1)/dx(1)

D(1,2) =  (2*L*(x(1)-d)*x(2))/( ((x(1)-d)^2 + x(2)^2)^(3/2) )...
		  +(2*L*x(1)*x(2))/( (x(1)^2 + x(2)^2)^(3/2) ); % df(2)/dx(1)

D(2,1) =  -2*L*x(2)*x(1)/( (x(1)^2 + x(2)^2)^(3/2) )...
		  -2*L*x(2)*(x(1) - d)/(((x(1)-d)^2 + x(2)^2)^(3/2));  % df(1)/dx(2)

D(2,2) =  -a(1) + 2*L/sqrt( x(1)^2 + x(2)^2 ) - (2*L*x(2)^2)/( ( x(1)^2 + x(2)^2 )^(3/2) )...
		  -a(2) + 2*L/sqrt( (x(1) - d)^2 + x(2)^2 ) -(2*L*x(2)^2)/(((x(1)-d)^2 + x(2)^2)^(3/2));        % df(2)/dx(2)

return;
