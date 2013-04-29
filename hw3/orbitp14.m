% orbit - Program to compute the orbit of a comet.
clear all;  help orbit;  % Clear memory and print header

%* Set initial position and velocity of the comet.
r0 = 1; % input('Enter initial radial distance (AU): ');  
v0 = pi/2; %input('Enter initial tangential velocity (AU/yr): ');
r = [r0 0];  v = [0 v0];
alp = .02;
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines
%%%two initial positions and two initial velocities

%* Set physical parameters (mass, G*M)
GM = 4*pi^2;      % Grav. const. * Mass of Sun (au^3/yr^2)
mass = 1.;        % Mass of comet 
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;
rad_to_deg = 57.2957795;
%* Loop over desired number of steps using specified
%  numerical method.
nStep = 300; %input('Enter number of steps: ');
tau = .0333333; %input('Enter time step (yr): '); 
disp('Numerical method: Adaptive R-K');
pause(1);
for iStep=1:nStep
  %* Record position and energy for plotting.
  rplot(iStep) = norm(r);           % Record position for polar plot
  thplot(iStep) = atan2(r(2),r(1));
  tplot(iStep) = time;
  kinetic(iStep) = .5*mass*norm(v)^2;   % Record energies
  potential(iStep) = - GM*mass/(norm(r));
  %* Calculate new position and velocity using desired method.
    [state time tau] = rka(state,time,tau,adaptErr,'gravrk',GM);
    r = [state(1) state(2)];   % Adaptive Runge-Kutta
    v = [state(3) state(4)];
end
  L = r0*v0;
  a = sqrt(1 + GM*(mass^2)*alp/(L^2));
i = 1;
  for j=1:300
    if rplot(j) > .99
      rmax(i) = rplot(j);
      thetad(i) = rad_to_deg * thplot(j);
      i = i + 1;
    end
  end
for k=1:(length(thetad)-1)
    thetadiff(k) = abs(thetad(k+1))-abs(thetad(k));
  end
  for l=1:length(thetadiff)
    if(abs(thetadiff(l)) < 40)
      thetadiff(l) = thetadiff(l+1);
    end
  end
avgdiff = sum(abs(thetadiff))/length(thetadiff);
disp('Theoretical precession is 360(1-a)/a = -46.6602');
fprintf('Calculated precession is avgdiff = -%g\n', avgdiff);


%* Graph the trajectory of the comet.
figure(1); clf;  % Clear figure 1 window and bring forward
polar(thplot,rplot,'-');  % Use polar plot for graphing orbit
xlabel('Distance (AU)');  grid;
pause(1)   % Pause for 1 second before drawing next plot

%* Graph the energy of the comet versus time.
figure(2); clf;   % Clear figure 2 window and bring forward
totalE = kinetic + potential;   % Total energy
plot(tplot,kinetic,'-.',tplot,potential,'--',tplot,totalE,'-')
legend('Kinetic','Potential','Total');
xlabel('Time (yr)'); ylabel('Energy (M AU^2/yr^2)');
