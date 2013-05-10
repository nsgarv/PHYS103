%program solves and plots the Lotka-Volterra preditor-prey
%system of equations
%
%dx/dt = ax(t) - cy(t)x(t)
%dy/dt = -by(t) + dx(t)y(t)
%x(t) = rabits
%y(t) = foxes
%a = rabit growth rate
%b = fox death rate
%c,d characterize animal interactions


clear all; help foxes;

a =2*12; %2[1/mo] --converted into 1/year
b =1*12; %[1/mo] --Converted into 1/year
c =0.12; %[1/year]
d =0.06; %[1/year]

x1 = 300; %Initial population of rabits
y1 = 150; %initial population of foxes
time = 0; %initial time
tau = 1/365; %time step in units of 1/year

xt = x1;
yt = y1;
state = [xt,yt]; %initial population
param =[a, b, c, d]; %creating a parameter vector to pass to derivative function
maxstep = 1000; %timesteps

for iStep=1:maxstep  %loop over interval to produce next value for plotting

foxplot(iStep) = yt;
rplot(iStep) = xt;	
tplot(iStep) = time;

time = time + tau;

state = rk4(state,time,tau,'deriveco',param); %call to rk4 and derivavtiv function
xt = state(1);
yt = state(2);

end
figure(1)
plot(tplot,rplot,'-',tplot,foxplot,'-');
legend('Rabit population as a function of time', 'Fox population as a function of time');
xlabel('time(years)')
figure(2)
plot(foxplot,rplot);
legend('Rabit population as a function of Foxes');
xlabel('Foxes');
ylabel('Rabits');
title('Prey as a function of preditors');


