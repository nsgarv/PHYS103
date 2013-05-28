%E-e*sin(E) = M;
%E is eccentric anomoly
%e is eccentricity
%M is mean anomoly
%Problem 4.17. Plot E(M) for eccentricity values of ε = 0.1, 0.9 . Take 50 iterations.

%find E using newton's method

% newtn - Program to solve nonlinear kepler equation
% using Newton's method.  Equations defined by function fnewtp3.m
clear all;  help p3;  % Clear memory and print header
ecc = [.1 .2 .3 .4 .5 .6 .7 .8 .9];

for z=1:9
x0 = 1;%input('Enter the initial guess (row vector): ');
%* Set initial guess and parameters
count = 50;
for (iteration=1:count)

	M = linspace(0,2*pi,50);
	e = ecc(z);
	param = zeros(1,2);
	param = [e M(iteration)];
	x = x0;  % Copy initial guess
	%xp(:,1) = x(:); % Record initial guess for plotting

	%* Loop over desired number of steps 
	nStep = 10;   % Number of iterations before stopping
	for (iStep=1:nStep)
	
  		%* Evaluate function f and its first derivative df
  		[f df] = fnewtp3(param, x);      % fnewt returns value of f and df
  		%* set dx equal to df
  		dx = df;
  		%* Update the estimate for the root  
  		x = x - f/dx;              % Newton iteration for new x
  		%xp(:,iStep+1) = x(:); % Save current estimate for plotting
  		E(iteration) = x;
    
	end

end
figure(z);
plot(M,E,'-');
title('Eccentric anomoly vs Mean anomoly');
xlabel('Mean anomoly M');
ylabel('Eccentric anomoly E(M)');
end

%%%%%%%%%%%%
count = 50;

if 0
for (iteration=1:count)

	M = linspace(0,2*pi,50);
	e = .5;
	param = zeros(1,2);
	param = [e M(iteration)];
	x = x0;  % Copy initial guess
	%xp(:,1) = x(:); % Record initial guess for plotting

	%* Loop over desired number of steps 
	nStep = 10;   % Number of iterations before stopping
	for (iStep=1:nStep)
	
  		%* Evaluate function f and its first derivative df
  		[f df] = fnewtp3(param, x);      % fnewt returns value of f and df
  		%* set dx equal to df
  		dx = df;
  		%* Update the estimate for the root  
  		x = x - f/dx;              % Newton iteration for new x
  		%xp(:,iStep+1) = x(:); % Save current estimate for plotting
  		E(iteration) = x;
    
	end

end
plot(M,E,'b-');
end

if 0
%* Print the final estimate for the root
fprintf('After %g iterations the root is\n',nStep);
disp(x);
%* Plot the iterations from initial guess to final estimate
figure(1); clf;  % Clear figure 1 window and bring forward
plot(xp(1,:),xp(2,:),'o-',x(1),x(2),'*');
title(sprintf('Initial guess is %g  %g',x0(1),x0(2)));
grid;
end