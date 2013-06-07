
%%%%%%%%%%%%%%%%%%%
%                 %
%%% problem 6p9 %%%
%                 %
%%%%%%%%%%%%%%%%%%% 
% dftcs - Program to solve the diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme with DuFort-Frankel
clear; help dftcs;  % Clear memory and print header

%* Initialize parameters (time step, grid spacing, etc.).
tau =5e-5;% input('Enter time step: ');%grid spacing changed from 1.5e-4 to 5e-5 to 5e-6 
N = 61; %input('Enter the number of grid points: ');
L = 1.;  % The system extends from x=-L/2 to x=L/2
h = L/(N-1);  % Grid size
kappa = 1.;   % Diffusion coefficient
coeff = kappa*tau/h^2;
if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

%* Set initial and boundary conditions.
tt_old = zeros(N,1);
tt_new = zeros(N,1);
tt = zeros(N,1);          % Initialize temperature to zero at all points
tt(round(N/2)) = 1/h;     % Initial cond. is delta function in center


%* Set up loop and plot variables.
xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 600;               % Maximum number of iterations %timesteps changes vrom 200 to 600 to 6000
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots
  %% Self start in FTCS %%
  %* Compute new temperature using first iteration of FTCS scheme.
  tt(2:(N-1)) = tt(2:(N-1)) + ...
      coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
    tt_old = tt;
    tt = tt_new;
  
  sigma = h^2/(2*coeff);
  %after getting first FTCS, use DuFort-frankel
  for istep=2:nstep
    tt_new(2:(N-1)) = ((tau/(sigma*(1+(tau/sigma)))*...
      ((tt(3:N)) + (tt(1:N-2)))) +...
      ((1-tau/sigma)/(1+tau/sigma)*(tt_old(2:(N-1)))));
    tt_old = tt;
    tt = tt_new;

  %* Periodically record temperature for plotting.
    if( rem(istep,plot_step) < 1 )   % Every plot_step steps
      ttplot(:,iplot) = tt(:);       % record tt(i) for plotting
      tplot(iplot) = istep*tau;      % Record time for plots
      iplot = iplot+1;
      tt_old = tt;
      tt = tt_new;
    end
  end

%* Plot temperature versus x and t as wire-mesh and contour plots.
figure(1); clf;
mesh(tplot,xplot,ttplot);  % Wire-mesh surface plot
xlabel('Time');  ylabel('x');  zlabel('T(x,t)');
title(sprintf('DuFort-Frankel scheme tau = %g time step = %g',tau, nstep));
pause(1);
figure(2); clf;       
contourLevels = 0:0.5:10;  contourLabels = 0:5;     
cs = contour(tplot,xplot,ttplot,contourLevels);  % Contour plot
clabel(cs,contourLabels);  % Add labels to selected contour levels
xlabel('Time'); ylabel('x');
title('Temperature contour plot');
