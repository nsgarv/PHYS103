% dftcs - Program to solve the diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme.
clear; help dftcs;  % Clear memory and print header

%* Initialize parameters (time step, grid spacing, etc.).
tau = 1e-4; %input('Enter time step: ');
N = 61; %input('Enter the number of grid points: ');
L = 1.;  % The system extends from x=-L/2 to x=L/2
h = L/(N-2);  % Grid size
kappa = 1.;   % Diffusion coefficient
coeff = kappa*tau/(h^2);
if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

%* Set initial and boundary conditions.
tt = zeros(N,1);          % Initialize temperature to zero at all points
tt(round(3*N/4)) = 1/h;     % Initial cond. is delta function in center
%% The boundary conditions are tt(1) = tt(N) = 0

%* Set up loop and plot variables.
xplot = (0:N-1)*h -h/2 - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 300;               % Maximum number of iterations
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots

%* Loop over the desired number of time steps.
for istep=1:nstep  %% MAIN LOOP %%

  %* Compute new temperature using FTCS scheme.
  tt_new(2:(N-1)) = tt(2:(N-1)) + ...
      coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));

      tt_new(1) = tt_new(N-1);
      tt_new(N) = tt_new(2);

      tt = tt_new;
  
  %* Periodically record temperature for plotting.
  if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    ttplot(:,iplot) = tt(:);       % record tt(i) for plotting
    tplot(iplot) = istep*tau;      % Record time for plots
    iplot = iplot+1;
  end
end

%tt(:,round(N/2)
%* Plot temperature versus x and t as wire-mesh and contour plots.
figure(1); clf;
mesh(tplot,xplot,ttplot);  % Wire-mesh surface plot
xlabel('Time');  ylabel('x');  zlabel('T(x,t)');
title('Diffusion of a delta spike');
pause(1);
figure(2); clf;       
contourLevels = 0:0.5:10;  contourLabels = 0:5;     
cs = contour(tplot,xplot,ttplot,contourLevels);  % Contour plot
clabel(cs,contourLabels);  % Add labels to selected contour levels
xlabel('Time'); ylabel('x');
title('Temperature contour plot');
figure(3);
plot(xplot, ttplot(:,round(N/2)));
title('T(x,t=.015');
