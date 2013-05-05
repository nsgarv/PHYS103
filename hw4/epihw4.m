%% An epidemic model.
clear all;  % Clear memory
%% * Set population and endemic parameters.

%% Suppose that after recovery, there is a loss of immunity 
%   that causes recovered individuals to become susceptible. 
%   This re-infection mechanism can be represented as ρR, 
%   where ρ is the re-infection rate.
%   Modify the model to include this mechanism and plot  
%   S(t),I(t),R(t) on the same figure using ρ=0.03[1day].
%%
rho = 0.03; %re-infection rate[1day]
pop = 10000; %the city population (all susceptible initially)  
a = .002; %infection rate (1/(person x week)
r = .15; %recovery rate (1/day)
state=[pop,1,0];
param=[a/7,r,rho];
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;
%% * Loop over necessary number of steps using specified numerical method.
nStep_max = 10000;
tau = .01; %input('Enter time step (day): '); 

for iStep=1:nStep_max  
  %* Record individuals numbers for plotting.
  Splot(iStep) = state(1); 
  Iplot(iStep) = state(2); 
  Rplot(iStep) = state(3) -rho*state(3); 
  tplot(iStep) = time;
  %if( NumericalMethod == 1 )

    state = rk4mod(state,time,tau,'fepimod',param);
    time = time + tau;   
  %else
    %[state time tau] = rka(state,time,tau,adaptErr,'fepimod',param);

  dstate=fepimod(state,time,param);
  if (state(2) < 10 & dstate(2)<0)  
  break;                  % Break out of the for loop
  end
end
%% * Graph endemic dynamics versus time.
figure(1); clf;  % Clear figure 1 window and bring forward
plot(tplot,Splot,'-',tplot,Iplot,'--',tplot,Rplot,':');
xlabel('Time (day)');  grid;
ylabel('Individuals');
legend('Susceptible','Infected','Recovered')