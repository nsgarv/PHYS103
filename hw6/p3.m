%E-e*sin(E) = M;
%E is eccentric anomoly
%e is eccentricity
%M is mean anomoly
%Problem 4.17. Plot E(M) for eccentricity values of ε = 0.1, 0.9 . Take 50 iterations.

%find E using newton's method

% newtn - Program to solve a system of nonlinear equations 
% using Newton's method.  Equations defined by function fnewt.
clear all;  help newtn;  % Clear memory and print header

%* Set initial guess and parameters
x0 = input('Enter the initial guess (row vector): ');
x = x0;  % Copy initial guess
xp(:,1) = x(:); % Record initial guess for plotting

%* Loop over desired number of steps 
nStep = 10;   % Number of iterations before stopping
for iStep=1:nStep
	
  %* Evaluate function f and its Jacobian matrix D
  [f D] = fnewtp3(x);      % fnewt returns value of f and D
  %* Find dx by Gaussian elimination
  dx = f/D; 
  %* Update the estimate for the root  
  x = x - dx;              % Newton iteration for new x
  xp(:,iStep+1) = x(:); % Save current estimate for plotting
  
end

%* Print the final estimate for the root
fprintf('After %g iterations the root is\n',nStep);
disp(x);
%* Plot the iterations from initial guess to final estimate
figure(1); clf;  % Clear figure 1 window and bring forward
plot(xp(1,:),xp(2,:),'o-',x(1),x(2),'*');
title(sprintf('Initial guess is %g  %g',x0(1),x0(2)));
grid;