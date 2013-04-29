function xout = rk4(x,t,tau,derivsRK,param,theta)
%  Runge-Kutta integrator (4th order)
% Input arguments -
%   x = current value of dependent variable
%   t = independent variable (usually time)
%   tau = step size (usually timestep)
%   derivsRK = right hand side of the ODE; derivsRK is the
%             name of the function which returns dx/dt
%             Calling format derivsRK(x,t,param).
%   param = extra parameters passed to derivsRK
% Output arguments -
%   xout = new value of x after a step of size tau
%%F1 = f(x,t)
%%F2 = f(x+F1tau/2 , t+tau/2)
%x = state [r(1), r(2), v(1), v(2)];
%t = time;
%***derivsRK = gravrk which takes inputs state, time and GM***
GM = param;
gmp = (GM*.01)*cos(theta) +GM;
half_tau = 0.5*tau;
F1 = feval(derivsRK,x,t,gmp);  
t_half = t + half_tau;
xtemp = x + half_tau*F1;
F2 = feval(derivsRK,xtemp,t_half,gmp);  
xtemp = x + half_tau*F2;
F3 = feval(derivsRK,xtemp,t_half,gmp);
t_full = t + tau;
xtemp = x + tau*F3;
F4 = feval(derivsRK,xtemp,t_full,gmp);
xout = x + tau/6.*(F1 + F4 + 2.*(F2+F3));
return;
