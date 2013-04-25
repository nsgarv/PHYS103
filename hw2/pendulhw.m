% pendul - Program to compute the motion of a simple pendulum
% using the Euler or Verlet method
clear all;  help pendul      % Clear the memory and print header

%* Select the numerical method to use: Euler or Verlet
%%%NumericalMethod = menu('Choose a numerical method:', ...
%%%                       'Euler','Verlet');
theta0 = [5:5:175];

for i=1:length(theta0);
  %* Set initial position and velocity of pendulum
  %%%theta0 = input('Enter initial angle (in degrees): ');
  theta(i) = theta0(i)*pi/180;   % Convert angle to radians
  omega = 0;               % Set the initial velocity

  %* Set the physical constants and other variables
  g_over_L = 1;            % The constant g/L
  time(i) = 0;                % Initial time
  irev = 0;                % Used to count number of reversals
  tau = .05; %input('Enter time step: ');

  %* Take one backward step to start Verlet
  accel = -g_over_L*sin(theta(i));    % Gravitational acceleration
  theta_old(i) = theta(i) - omega*tau + 0.5*tau^2*accel;    

  %* Loop over desired number of steps with given time step
  %    and numerical method
  nstep = 5000; %input('Enter number of time steps: ');
  for istep=1:nstep  

    %* Record angle and time for plotting
    t_plot(istep) = time(i);            
    th_plot(istep) = theta(i)*180/pi;   % Convert angle to degrees
    time(i) = time(i) + tau;
  
    %* Compute new position and velocity using 
    %    Euler or Verlet method
    accel = -g_over_L*sin(theta(i));    % Gravitational acceleration
    %%%if( NumericalMethod == 1 )
      %%%theta_old = theta(i);               % Save previous angle
      %%%theta(i) = theta(i) + tau*omega;       % Euler method
      %%%omega = omega + tau*accel; 
    %%%else  
      theta_new(i) = (2*theta(i) - theta_old(i) + tau^2*accel);
      theta_old(i) = theta(i);         % Verlet method
      theta(i) = theta_new(i);  

  
    %* Test if the pendulum has passed through theta = 0;
    %    if yes, use time to estimate period
    if( theta(i)*theta_old(i) < 0 )  % Test position for sign change
      %fprintf('Turning point at time t= %f \n',time(i));
      if( irev == 0 )          % If this is the first change,
        time_old(i) = time(i);       % just record the time
      else
        period(irev) = 2*(time(i) - time_old(i))
        time_old(i) = time(i);
      end
      irev = irev + 1;       % Increment the number of reversals
    end
    
    Ts(i) = 2*pi*sqrt(g_over_L);
  end
Tp = 2*pi*sqrt(g_over_L)*(1+(1/16)*((pi/180)*theta0).^2);
  %* Estimate period of oscillation, including error bar
  AvePeriod(i) = mean(period);
end

%ErrorBar = std(period)/sqrt(irev);
%fprintf('Average period = %g +/- %g\n', AvePeriod,ErrorBar);
%plot(theta0, AvePeriod);
plot(theta0, AvePeriod, '-+', theta0, Ts, '--',theta0, Tp, '-o');
title('Period T(\theta)');
ylabel('Period (T)');
xlabel('Initial angle \theta');
legend('Verlet Method', 'Small angle', 'Other appoximation')
%* Graph the oscillations as theta versus time
%%clf;  figure(gcf);         % Clear and forward figure window
%%plot(t_plot,th_plot,'+');
%%xlabel('Time');  ylabel('\theta (degrees)');
