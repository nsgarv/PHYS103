% newtn - Program to solve a system of nonlinear equations 
% using Newton's method.  Equations defined by function fnewt.
clear all;  help newtnp1;  % Clear memory and print header
if 0
x0(1) = [1 1];
x0(2) = [1.1 3.1];
x0(3) = [2 2];
x0(4) = [1 1];
param(1) = [1 3];
param(2) = [1 3];
param(3) = [2 2];
param(4) = [1 2];
end
tau(1) = 50;
tau(2) = 50;
tau(3) = 50;
tau(4) = 500;


for k=1:4
%* Set initial guess and parameters

disp('x0(1) = [1 1]; x0(2) = [1.1 3.1]; x0(3) = [2 2]; x0(4) = [1 1];');
disp('param(1) = [1 3]; param(2) = [1 3]; param(3) = [2 2]; param(4) = [1 2];');


x0 = input('Enter the initial guess (row vector): ');

x = x0;  % Copy initial guess
xp(:,1) = x(:); % Record initial guess for plotting
param = input('Enter A and B in row vector form [A B]: ');
%* Loop over desired number of steps 
nStep = 10;   % Number of iterations before stopping
for iStep=1:nStep
	
  %* Evaluate function f and its Jacobian matrix D
  [f D] = fnewtp1(x,param);      % fnewt returns value of f and D
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

% = input('Plot data from lorenz program? (1=Yes/0=No): ');
%if( flag == 1 )
hold on
nStep = 50;
%tau = 500; 
err = .01;
state=x0;
time=0;
for iStep=1:nStep  
  xplot(iStep) = state(1); 
  yplot(iStep) = state(2); 
  state = rka(state,time,tau(k),err,'derivschem',param);
  time = time + tau(k);   
end 

plot(xplot,yplot,'r-');
k = k+1;
end
