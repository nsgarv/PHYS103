m = 80; %mass in kg
s = .5; %cross sectional area m^2
Cd = 0.5; %drag coefficient
theta0 = 22.5;
grav = 9.81;
r = [0 0];
tau = .001;
rho_hialt = .94;
rho_sea = 1.29;

%%% longjump sealevel
speed = 10; %input('Enter initial speed (m/s): '); 
v1 = [speed*cos(theta0*pi/180), ...
      speed*sin(theta0*pi/180)];     % Initial velocity
r = r1;  v = v1;  % Set initial position and velocity

air_const = -0.5*Cd*rho_sea*s/m;

for i=1:10000
	nsxplot(i) = r(1);
	nsyplot(i) = r(2);
	t = (i-1)*tau;     % Current time

%* Calculate the acceleration of the jumper 
  accel = air_const*norm(v)*v;   % Air resistance
  accel(2) = accel(2)-grav;      % Gravity

%* Calculate the next position and velocity using Euler method
  r = r + tau*v;                 % Euler step
  v = v + tau*accel;     

  %* If ball reaches ground (y<0), break out of the loop
  if( r(2) < 0 )  
    nsxplot(i+1) = r(1);  % Record last values computed
	nsyplot(i+1) = r(2);
    break;                  % Break out of the for loop
  end 
end

nsX = [nsxplot(i+1) nsxplot(i) nsxplot(i-1)];
nsY = [nsyplot(i+1) nsyplot(i) nsyplot(i-1)];
Y0 = 0;

nsxdistance = intrpf(Y0,nsY,nsX);
nstime = nsxdistance/v1(1);
fprintf('Maximum range (sealevel) is %g meters\n',nsxdistance);
fprintf('Time of flight (sealevel) is %g seconds\n', nstime);

clear t;
clear time;
clear air_const;
clear accel;
clear r;
clear v;
r = [0 0];
%%%longjump high altitude

speed = 10; %input('Enter initial speed (m/s): '); 
v1 = [speed*cos(theta0*pi/180), ...
      speed*sin(theta0*pi/180)];     % Initial velocity
r = r1;  v = v1;  % Set initial position and velocity

air_const = -0.5*Cd*rho_hialt*s/m;

for i=1:10000
	nhxplot(i) = r(1);
	nhyplot(i) = r(2);
	t = (i-1)*tau;     % Current time

%* Calculate the acceleration of the jumper 
  accel = air_const*norm(v)*v;   % Air resistance
  accel(2) = accel(2)-grav;      % Gravity

%* Calculate the next position and velocity using Euler method
  r = r + tau*v;                 % Euler step
  v = v + tau*accel;     

  %* If ball reaches ground (y<0), break out of the loop
  if( r(2) < 0 )  
    nhxplot(i+1) = r(1);  % Record last values computed
	nhyplot(i+1) = r(2);
    break;                  % Break out of the for loop
  end 
end

nhX = [nhxplot(i+1) nhxplot(i) nhxplot(i-1)];
nhY = [nhyplot(i+1) nhyplot(i) nhyplot(i-1)];
Y0 = 0;

nhxdistance = intrpf(Y0,nhY,nhX);
nhtime = nhxdistance/v1(1);
fprintf('Maximum range (high altitude) is %g meters\n',nhxdistance);
fprintf('Time of flight (high altitude) is %g seconds\n', nhtime);

%* Graph the trajectory of the jumper %gcf is get current figure
clf;  figure(gcf);   % Clear figure window and bring it forward
% Mark the location of the ground by a straight line

xground = [0 (max(X)+1)];  yground = [0 0];
% Plot the computed trajectory and parabolic, no-air curve
plot(nsxplot,nsyplot,'-', nhxplot, nhyplot, '--', xground,yground,'-+');
legend('Sea level', 'High altitude');
xlabel('Range (m)');  ylabel('Height (m)');
title('Longjump');

axis equal

clear t;
clear time;
clear air_const;
clear accel;
clear r;
clear v;

%%% distance of 8.9 meters and rho_hialt, what is initial velocity?
%function [y1,...,yN] = myfun(x1,...,xM)
%beamonh
clear('all');
rho_SL=1.29;
rho_HA=0.94;
speed = 10;
[range_SL,xplot_SL,yplot_SL]=fbeamon(speed,rho_SL);
[range_HA,xplot_HA,yplot_HA]=fbeamon(speed,rho_HA);
speedB=fzero(iline('fbeamon(speed,rho)-8.9','speed','rho'),speed,[],rho_HA);
[rangeB_SL,xplotB_SL,yplotB_SL]=fbeamon(speedB,rho_SL);
[rangeB_SL,xplotB_HA,yplotB_HA]=fbeamon(speedB,rho_HA);


