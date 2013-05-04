function [deriv] = fepidemic_class(s,t,param)
%  Returns right-hand side of Kepler ODE; used by Runge-Kutta routines
%  Inputs
%    s      State vector [S I R]
%    t      Time (not used)
%    param  [r a]
a = param(1);   % Infection rate (1/(person x day)) 
r = param(2);   % Recovery rate (1/day) 
%* Return derivatives [dS/dt dI/dt dR/dt]
dS=-a*s(1)*s(2);
dI=a*s(1)*s(2)-r*s(2);
dR=r*s(2);
deriv = [dS dI dR];
return;
