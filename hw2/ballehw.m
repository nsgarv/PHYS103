% balle - Program to compute the trajectory of a baseball
%         using the Euler method.
clear all;  help balle;  % Clear memory and print header

%* Set initial position and velocity of the baseball
y1 = 1; %input('Enter initial height (meters): ');   
r1 = [0, y1];     % Initial vector position
speed = 50; %input('Enter initial speed (m/s): '); 
theta = 45; %input('Enter initial angle (degrees): '); 
v1 = [speed*cos(theta*pi/180), ...
      speed*sin(theta*pi/180)];     % Initial velocity
r = r1;  v = v1;  % Set initial position and velocity

%* Set physical parameters (mass, Cd, etc.)
%Cd = 0.35;      % Drag coefficient (dimensionless)
area = 4.3e-3;  % Cross-sectional area of projectile (m^2)
grav = 9.81;    % Gravitational acceleration (m/s^2)
mass = 0.145;   % Mass of projectile (kg)
rho = 1.2;    % Density of air (kg/m^3)

%%%%
%%%%
miles_per_hour_to_meters_per_second = 0.44704;
%*--Cd calculations.
vmph = [75 100 125];
vCd = [.4 .28 .23];
for i=1:3
  varms(i) = vmph(i) * miles_per_hour_to_meters_per_second;
end

%* Loop until ball hits ground or max steps completed
tau = .1; %input('Enter timestep, tau (sec): ');  % (sec)
maxstep = 1000;   % Maximum number of steps

  %* If ball reaches ground (y<0), break out of the loop
for istep=1:maxstep
  %* Record position (computed and theoretical) for plotting
  xplot(istep) = r(1);   % Record trajectory for plot
  yplot(istep) = r(2);
  t = (istep-1)*tau;     % Current time
  xNoAir(istep) = r1(1) + v1(1)*t;
  yNoAir(istep) = r1(2) + v1(2)*t - 0.5*grav*t^2;

%if (norm(v) < 85*.44704)
%Cd = .5; 
%else 
Cd = intrpf(norm(v), varms, vCd);
if (Cd >= .5)
  Cd = .5;
end

%end
  air_const = -0.5*Cd*rho*area/mass;  % Air resistance constant
  %* Calculate the acceleration of the ball 
  accel = air_const*norm(v)*v;   % Air resistance
  accel(2) = accel(2)-grav;      % Gravity
  
  %* Calculate the new position and velocity using Euler method
  r = r + tau*v;                 % Euler step
  v = v + tau*accel;     
  %* If ball reaches ground (y<0), break out of the loop
  if( r(2) < 0 )  
    xplot(istep+1) = r(1);  % Record last values computed
  yplot(istep+1) = r(2);
    break;                  % Break out of the for loop
  end 
end

%in interpf: xi = x vector, yi = vector, x0 is the y=0 point
%%%%
%%%%
X = [xplot(istep+1) xplot(istep) xplot(istep-1)];
Y = [yplot(istep+1) yplot(istep) yplot(istep-1)];
Y0 = 0;

xdistance = intrpf(Y0,Y,X);
time = xdistance/v1(1);
fprintf('Maximum range (corrected) is %g meters\n',xdistance);
fprintf('Time of flight (corrected) is %g seconds\n', time);
%%%%

%* Print maximum range and time of flight
fprintf('Maximum range is %g meters\n',r(1));
fprintf('Time of flight is %g seconds\n',istep*tau);

%* Graph the trajectory of the baseball %gcf is get current figure
clf;  figure(gcf);   % Clear figure window and bring it forward
% Mark the location of the ground by a straight line
xground = [0 max(xNoAir)];  yground = [0 0];
% Plot the computed trajectory and parabolic, no-air curve
plot(xplot,yplot,'-+',xNoAir,yNoAir,'-o',xground,yground,'-');
legend('variable drag','Theory (No air)  ');
xlabel('Range (m)');  ylabel('Height (m)');
title('Projectile motion');

