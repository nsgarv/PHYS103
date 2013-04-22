m = 80; %mass in kg
s = .5; %cross sectional area m^2
Cd = 0.5; %drag coefficient
theta0 = 22.5;
grav = 9.81;
r = [0 0];
tau = .001;
rho_hialt = .94;
rho_sea = 1.29;

speed = input('Enter initial speed (m/s): '); 
v1 = [speed*cos(theta0*pi/180), ...
      speed*sin(theta0*pi/180)];     % Initial velocity
r = r1;  v = v1;  % Set initial position and velocity
altitude = input('Select air density (1=hi altitude, 0=sea level): ');

	if(altitude == 1)
		rho = rho_hialt;
	else
		rho = rho_sea;
	end

air_const = -0.5*Cd*rho*s/m;

for i=1:10000
	xplot(i) = r(1);
	yplot(i) = r(2);
	t = (i-1)*tau;     % Current time

%* Calculate the acceleration of the jumper 
  accel = air_const*norm(v)*v;   % Air resistance
  accel(2) = accel(2)-grav;      % Gravity

%* Calculate the next position and velocity using Euler method
  r = r + tau*v;                 % Euler step
  v = v + tau*accel;     

  %* If ball reaches ground (y<0), break out of the loop
  if( r(2) < 0 )  
    xplot(i+1) = r(1);  % Record last values computed
	yplot(i+1) = r(2);
    break;                  % Break out of the for loop
  end 
end

X = [xplot(i+1) xplot(i) xplot(i-1)];
Y = [yplot(i+1) yplot(i) yplot(i-1)];
Y0 = 0;

xdistance = intrpf(Y0,Y,X);
time = xdistance/v1(1);
fprintf('Maximum range (corrected) is %g meters\n',xdistance);
fprintf('Time of flight (corrected) is %g seconds\n', time);

%* Print maximum range and time of flight
fprintf('Maximum range is %g meters\n',r(1));
fprintf('Time of flight is %g seconds\n',i*tau);

%* Graph the trajectory of the jumper %gcf is get current figure
clf;  figure(gcf);   % Clear figure window and bring it forward
% Mark the location of the ground by a straight line

xground = [0 (max(X)+1)];  yground = [0 0];
% Plot the computed trajectory and parabolic, no-air curve
plot(xplot,yplot,':',xground,yground,'-+');
legend('Euler method');
xlabel('Range (m)');  ylabel('Height (m)');
title('Longjump');