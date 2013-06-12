% Equilibrium positions in the spring mass system
% newtn - Program to solve a system of nonlinear equations 
% using Newton's method.  Equations defined by function fnewtp1.
clear all;  help problem1;  % Clear memory and print header

k1 = 10; % N/m
k2 = 20; % N/m
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
a = [k1 k2 L d m g];

%* Loop over desired number of steps 
   % Number of iterations before stopping
nStep = 20;
%while((xp(:,iStep-1)-xp(:,iStep) > 1e-6) && ((yp(:,iStep-1)-yp(:,iStep)) > 1e-6))
for iStep=1:nStep	
  %* Evaluate function f and its Jacobian matrix D
  [f D] = fnewtp1(xa,a);      % fnewtp1 returns value of f and D
  %* Find dx by Gaussian elimination
  dx = f/D; 
  %* Update the estimate for the root
  fprintf('x,y = %g , %g\n',xa(1), xa(2)); 
  xa = xa - dx;              % Newton iteration for new x
  xp(:,iStep+1) = xa(1);
  yp(:,iStep+1) = xa(2); % Save current estimate for plotting
  if ( abs(dx(1)) < 1e-6 & abs(dx(2)) < 1e-6 )
  	break;
  end
end

%* Print the final estimate for the root
fprintf('After %g iterations the Equilibrium is\n',iStep);
disp(xa);

