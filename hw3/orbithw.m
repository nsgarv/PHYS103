%% modify the orbit program to to compute and plot the absolute fractional error in r(theta)
%% versus time.

% orbit - Program to compute the orbit of a comet.
clear all;  help orbit;  % Clear memory and print header

%* Set initial position and velocity of the comet.
r0 = 1; %%%input('Enter initial radial distance (AU): ');  
v0 = pi; %%%input('Enter initial tangential velocity (AU/yr): ');
r = [r0 0];  v = [0 v0];
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines
%%%two initial positions and two initial velocities

%* Set physical parameters (mass, G*M)
GM = 4*pi^2;      % Grav. const. * Mass of Sun (au^3/yr^2)
mass = 1.;        % Mass of comet 
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;

%* Loop over desired number of steps using specified
%  numerical method.
nStep = input('Enter number of steps: ');
tau = input('Enter time step (yr): '); 
NumericalMethod = 2; disp('Numerical method is Euler-Cormer');
pause(1); %%%menu('Choose a numerical method:', ...
       %%%'Euler','Euler-Cromer','Runge-Kutta','Adaptive R-K');
for iStep=1:nStep  

  %* Record position and energy for plotting.
  rplot(iStep) = norm(r);           % Record position for polar plot
  thplot(iStep) = atan2(r(2),r(1));
  tplot(iStep) = time;
  kinetic(iStep) = .5*mass*norm(v)^2;   % Record energies
  potential(iStep) = - GM*mass/norm(r);
  
  %* Calculate new position and velocity using desired method.
  if( NumericalMethod == 1 )
    accel = -GM*r/norm(r)^3;   
    r = r + tau*v;             % Euler step
    v = v + tau*accel; 
    time = time + tau;   
  elseif( NumericalMethod == 2 ) 
    accel = -GM*r/norm(r)^3;   
    v = v + tau*accel; 
    r = r + tau*v;             % Euler-Cromer step
    time = time + tau;     
  elseif( NumericalMethod == 3 )
    state = rk4(state,time,tau,'gravrk',GM);
    r = [state(1) state(2)];   % 4th order Runge-Kutta
    v = [state(3) state(4)];
    time = time + tau;   
  else
    [state time tau] = rka(state,time,tau,adaptErr,'gravrk',GM);
    r = [state(1) state(2)];   % Adaptive Runge-Kutta
    v = [state(3) state(4)];
  end
end

%thplot is the theta angle for every timestep.
L = r0*mass*v0*1;
totalE = kinetic + potential;   % Total energy
mass;
GM;
f=GM.^2;

j=(kinetic(1)+potential(1))*L^2;
eh = ((2*totalE*L^2)/(((GM).^2)*mass^3));
a = (max(rplot)+min(rplot))/2;
ecc = sqrt(1+(2*totalE*norm(L).^2)/((GM).^2)*mass^3);
for i=1:nStep
rtheta(i) = a*(1-ecc.^2)/(1-ecc.*cos(thplot(i)));
end
frac_err = abs((rtheta-rplot)./rtheta);
%* Graph the trajectory of the comet.
figure(1); clf;  % Clear figure 1 window and bring forward
polar(thplot,rplot,'+');  % Use polar plot for graphing orbit
xlabel('Distance (AU)');  grid;
pause(1)   % Pause for 1 second before drawing next plot

%* Graph the energy of the comet versus time.
figure(2); clf;   % Clear figure 2 window and bring forward
plot(tplot,kinetic,'-.',tplot,potential,'--',tplot,totalE,'-')
legend('Kinetic','Potential','Total');
xlabel('Time (yr)'); ylabel('Energy (M AU^2/yr^2)');
figure(3); clf;
semilogy(tplot,frac_err)

