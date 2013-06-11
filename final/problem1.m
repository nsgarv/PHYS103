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
nStep = 100;
%while((xp(:,iStep-1)-xp(:,iStep) > 1e-6) && ((yp(:,iStep-1)-yp(:,iStep)) > 1e-6))
for iStep=1:nStep	
  %* Evaluate function f and its Jacobian matrix D
  [f D] = fnewtp1(xa,a);      % fnewtp1 returns value of f and D
  %* Find dx by Gaussian elimination
  dx = f/D 
  %* Update the estimate for the root  
  xa = xa - dx;              % Newton iteration for new x
  xp(:,iStep+1) = xa(1);
  yp(:,iStep+1) = xa(2); % Save current estimate for plotting
  if ( abs(dx(1)) < 1e-6 & abs(dx(2)) < 1e-6 )
  	break;
  end

  	%(xp(:,iStep-1)-xp(:,iStep))
  	%(yp(:,iStep-1)-yp(:,iStep))
  	%if ((xp(:,iStep-1)-xp(:,iStep) > 1e-6) && ((yp(:,iStep-1)-yp(:,iStep)) > 1e-6))
  	%	break;
  	%end
end

%* Print the final estimate for the root
fprintf('After %g iterations the root is\n',iStep);
disp(xa);

if 0
%* Plot the iterations from initial guess to final estimate
figure(1); clf;  % Clear figure 1 window and bring forward
subplot(1,2,1) % Left plot
  plot3(xp(1,:),xp(2,:),'o-',...
      xa(1),xa(2),'*');
  xlabel('x');  ylabel('y'); zlabel('z');
  view([-37.5, 30]);  % Viewing angle
  title(sprintf('Initial guess is %g  %g  %g',x0(1),x0(2),x0(3)));
  grid; drawnow;
subplot(1,2,2) % Right plot
  plot3(xp(1,:),xp(2,:),xp(3,:),'o-',...
      x(1),x(2),x(3),'*');
  xlabel('x');  ylabel('y'); zlabel('z');
  view([-127.5, 30]);  % Viewing angle
  title(sprintf('After %g iterations, root is %g  %g  %g',...
                                       nStep,x(1),x(2),x(3)));
  grid; drawnow;
% Plot data from lorenz (if available). To write lorenz data, use:
% >>save xplot; save yplot; save zplot;
% after running the lornez program.
flag = input('Plot data from lorenz program? (1=Yes/0=No): ');
if( flag == 1 )
  figure(2); clf;  % Clear figure 1 window and bring forward
  load xplot; load yplot; load zplot;
  plot3(xplot,yplot,zplot,'-',xp(1,:),xp(2,:),xp(3,:),'o--');
  xlabel('x'); ylabel('y'); zlabel('z');
  view([40 10]);  % Rotate to get a better view 
  grid;           % Add a grid to aid perspective
end
end
