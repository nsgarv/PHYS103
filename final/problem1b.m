% Equilibrium positions in the spring mass system
% newtn - Program to solve a system of nonlinear equations 
% using Newton's method.  Equations defined by function fnewtp1.
clear all;  help problem1;  % Clear memory and print header

k1 = 10; % N/m
%k2 = 20; % N/m
k2 = linspace(0,20,20);
L = .1; 
m = .1; % kg
d = .1; % m
g = 9.81; % m/s^2

y0 = (m*g)/(k1);
y = y0;

x0 = 0;
x = [x0,y0];
xa = x;
%* Set initial guess and parameters
xp(:,1) = x(1);
yp(:,1) = x(2); % Record initial guess for plotting

for i=1:length(k2)
a = [k1 k2(i) L d m g];
  nStep = 20;

  for iStep=1:nStep	
    %* Evaluate function f and its Jacobian matrix D
    [f D] = fnewtp1(xa,a);      % fnewtp1 returns value of f and D
    %* Find dx by Gaussian elimination
    dx = f/D; 
    %* Update the estimate for the root
    %fprintf('x,y = %g , %g\n',xa(1), xa(2)); 
    xa = xa - dx;              % Newton iteration for new x
    xp(:,iStep+1) = xa(1);
    yp(:,iStep+1) = xa(2); % Save current estimate for plotting
    xplot(i) = xa(1);
    yplot(i) = xa(2);
  end
end

plot(xplot,k2,yplot,k2);
xlabel('Equilibrium positions of x and y');
ylabel('k2 (N/m)');
legend('x vs k2', 'y vs k2');
title('equilibrium positions as a function of k2 from 0 - 20');


