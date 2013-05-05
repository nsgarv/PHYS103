function [deriv] = fepimod(s,t,param)
%  Returns right-hand side of Kepler ODE; used by Runge-Kutta routines
%  Inputs
%    s      State vector [S I R]
%    t      Time (not used)
%    param  [r a]
% s(1) = susceptable, s(2) = infected, s(3) = recovered.
a = param(1);   % Infection rate (1/(person x day)) 
r = param(2);   % Recovery rate (1/day) 
rho = param(3); % Re-infection rate
%* Return derivatives [dS/dt dI/dt dR/dt]
dS=-a*s(1)*s(2)+rho*s(3);
dI=a*s(1)*s(2)-r*s(2);
dR=r*s(2)-rho*s(3);
deriv = [dS dI dR];
return;
