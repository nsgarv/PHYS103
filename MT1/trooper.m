% balle - Program to compute the trajectory of a baseball
%         using the Euler method.
clear;  help balle;  % Clear memory and print header

%* Set initial position and velocity of the baseball
h = 600; %initial height in meters  
speed = 0; %initial speed is 0 
% Initial velocity
v = speed;  % Set initial position and velocity

%* Set physical parameters (mass, Cd, etc.)
Cd = 0.5;      % Drag coefficient (dimensionless)
area1 = .2; % Cross-sectional area of trooper 
area2 = 2;  % Cross-sectional area of of schute
grav = 9.81;    % Gravitational acceleration (m/s^2)
mass = 80;   % Mass of trooper
rho = 1.2;    % Density of air (kg/m^3)
air_const1 = -0.5*Cd*rho*area1/mass;  % Air constant freefall
air_const2 = -0.5*Cd*rho*area2/mass;  % Air constant parachute
hn = h;
vn = v;

%* Loop until trooper hits ground or max steps completed
tau = .02; %time step
maxstep = 1000;   % Maximum number of steps
for istep=1:maxstep
  %* Record position for plotting
  hplot(istep) = h;
  t = (istep-1)*tau;     % Current time
  timev(istep) = t;
  tn(istep) = t;
  %* Calculate the acceleration
  if (t<5)
    accel = grav + air_const1*norm(v)*v;   % Air resistance
  else
    accel = grav + air_const2*norm(v)*v;
  end

  yNoAir(istep) = hn - vn*tn(istep) - 0.5*grav*tn(istep)^2;
    if (yNoAir(istep) > -.02 & yNoAir(istep)< .02)
      yNoAir(istep +1) = yNoAir(istep);
      tstop = istep;
    end
  %* Calculate the new position and velocity using Euler method
  h = h - tau*v;                 % Euler step
  v = v + tau*accel;     
  %* If trooper reaches ground (h<0), break out of the loop
  if( h < 0 )  
     % Record last values computed
	hplot(istep+1) = h;
    break;                  % Break out of the for loop
  end 
end
time = t;

clf;  figure(gcf);   % Clear figure window and bring it forward

%plot(xplot,yplot,'-+',xNoAir,yNoAir,'-',xground,yground,'-');
X = [timev(length(timev)-2) timev(length(timev)-1) timev(length(timev))];
Y = [hplot(length(hplot)-2) hplot(length(hplot)-1) hplot(length(hplot))];
Y0 = 0;

tactual = intrpf(Y0,Y,X);
fprintf('Time of flight estimted is %g seconds\n', time);
fprintf('Time of flight interpolated is %g seconds\n', tactual);
fprintf('Parachute impact velocity is %g m/s\n', v);

%disp('corrected parachute flighttime is %d', timel);
index = length(timev);
plot(timev,hplot(1:index),'-b',5,hplot(1:index),'-r',timev(1:tstop),yNoAir(1:tstop),'-b');
%legend('Euler method','Theory (No air)  ');
xlabel('Time (s)');  ylabel('Height (m)');
title('paratrooper parachute vs freefall');

