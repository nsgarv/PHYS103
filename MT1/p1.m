% orbit - Program to compute the orbit of a comet.
clear all;  help orbit;  % Clear memory and print header
%* Set initial position and velocity of the comet.
r0 = 1; %input('Enter initial radial distance (AU): ');  
v0 = 2*pi; %input('Enter initial tangential velocity (AU/yr): ');
r = [r0 0];  v = [0 v0];
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines
%%%two initial positions and two initial velocities

%* Set physical parameters (mass, G*M)
GM = 4*pi^2;      % Grav. const. * Mass of Sun (au^3/yr^2)
mass = 1.;        % Mass of comet 
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;

Cd = GM/(100*norm(v)*v0);
param = [GM Cd];
nStep = 200; %input('Enter number of steps: ');
tau = .02; %input('Enter time step (yr): '); 
for iStep=1:nStep  

  %* Record position and energy for plotting.
  rplot(iStep) = norm(r);           % Record position for polar plot
  thplot(iStep) = atan2(r(2),r(1));
  tplot(iStep) = time;
  kinetic(iStep) = .5*mass*norm(v)^2;   % Record energies
  potential(iStep) = - GM*mass/norm(r);
  
    [state time tau] = rka(state,time,tau,adaptErr,'gravmod',param);
    r = [state(1) state(2)];   % Adaptive Runge-Kutta
    v = [state(3) state(4)];
end

a = abs(thplot);
l = length(thplot);
for jstep=1:l
  if (thplot(jstep) <= 0)
    theta(jstep) = (thplot(jstep) + 2*pi);
  else
    theta(jstep) = thplot(jstep);
  end
end

theta;
n=1;
for(kstep=1:length(theta))
  if(theta(kstep) > 6)
    thetaindex(n) = kstep;
    n = n+1;
  end
end
g = 1;
fstep = 1;
hi = 0;
gstep = 1;

while(fstep < length(thetaindex))
  hi = thetaindex(fstep + 1);
  lo = thetaindex(fstep);
  avgk(gstep) = sum(kinetic(lo):kinetic(hi))/(hi-lo);
  gstep = gstep +1;
    fstep = fstep +1;
end
indexthetaindex = [1:(length(thetaindex)-1)];
figure(3)
plot(indexthetaindex,avgk, '+');
ylabel('average kinetic energy per revolution');
xlabel('revolution number');
title('Kinetic energy per revolution');

%* Graph the trajectory of the comet.
figure(1); clf;  % Clear figure 1 window and bring forward
polar(thplot,rplot,'-');  % Use polar plot for graphing orbit
xlabel('Distance (AU)');  grid;
pause(1)   % Pause for 1 second before drawing next plot

%* Graph the energy of the comet versus time.
figure(2); clf;   % Clear figure 2 window and bring forward
totalE = kinetic + potential;   % Total energy
plot(tplot,kinetic,'-.',tplot,potential,'--',tplot,totalE,'-');
legend('Kinetic','Potential','Total');
xlabel('Time (yr)'); ylabel('Energy (M AU^2/yr^2)');
