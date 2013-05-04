%% An epidemic model.
clear all;  % Clear memory
%% * Set population and endemic parameters.
pop = input('Enter the city population (all susceptible initially): ');  
a = input('Enter infection rate (1/(person x week)): ');  
r = input('Enter recovery rate (1/day): ');  
state=[pop,1,0];
param=[a/7,r];
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;
%% * Loop over necessary number of steps using specified numerical method.
nStep_max = 10000;
tau = input('Enter time step (day): '); 
NumericalMethod = menu('Choose a numerical method:','Runge-Kutta','Adaptive R-K');
for iStep=1:nStep_max  
  %* Record individuals numbers for plotting.
  Splot(iStep) = state(1); 
  Iplot(iStep) = state(2); 
  Rplot(iStep) = state(3); 
  tplot(iStep) = time;
  if( NumericalMethod == 1 )
    state = rk4(state,time,tau,'fepidemic_class',param);
    time = time + tau;   
  else
    [state time tau] = rka(state,time,tau,adaptErr,'fepidemic_class',param);
  end
  dstate=fepidemic_class(state,time,param);
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