function xout = rk4(x,t,tau,derivsRK,param)
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
half_tau = 0.5*tau;
%pause(.25)
F1 = feval(derivsRK,x,t,param);
%pause(.25)
t_half = t + half_tau;
%pause(.25)
xtemp = x + half_tau*F1;
%pause(.25)
F2 = feval(derivsRK,xtemp,t_half,param);
%pause(.25) 
xtemp = x + half_tau*F2;
%pause(.25)
F3 = feval(derivsRK,xtemp,t_half,param);
%pause(.25)
t_full = t + tau;
%pause(.25)
xtemp = x + tau*F3;
%pause(.25)
F4 = feval(derivsRK,xtemp,t_full,param);
%pause(.25)
xout = x + tau/6.*(F1 + F4 + 2.*(F2+F3));
%pause(.25)
return;
