tt_old = zeros(N,1);
tt_new = zeros(N,1);
tt = zeros(N,1);          % Initialize temperature to zero at all points
tt(round(N/2)) = 1/h;     % Initial cond. is delta function in center
%% The boundary conditions are tt(1) = tt(N) = 0
 
%* Set up loop and plot variables.
xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 200;               % Maximum number of iterations
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots
for istep=1:1
    tt_new(2:(N-1)) = tt(2:(N-1)) + ...
      coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
    tt_old = tt;
    tt = tt_new;
end  
sigma = h^2/(2*coeff);
%* Loop over the desired number of time steps.
for istep=2:nstep  %% MAIN LOOP %%  
  %* Compute new temperature using FTCS scheme.
  tt_new(2:(N-1)) = ((tau/(sigma*(1+(tau/sigma)))*...
      ((tt(3:N)) + (tt(1:N-2)))) +...
      ((1-tau/sigma)/(1+tau/sigma)*(tt_old(2:(N-1)))));
  tt_old = tt;
  tt = tt_new;
  
end