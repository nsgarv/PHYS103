function [f df] = fnewtp3(param, E)
%  Function used by the single variable Newton's method
%  Inputs
%    param(1)=e  parameters eccentricity and mean anomoly
%    param(2)=M
%      E    Eccentric anomoly
%  Outputs
%    f     
%    D     first derivative of Eccentric anomoly equation

% Evaluate f(E)
%M - E + e * sin(E)
f = param(2) - E + param(1) * sin(E);

% Evaluate f'(E)
df = param(1) * cos(E) - 1;
return;
