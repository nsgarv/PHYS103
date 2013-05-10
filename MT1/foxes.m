%dx/dt = ax(t) - cy(t)x(t)
%dy/dt = -by(t) + dx(t)y(t)
%x(t) = rabits
%y(t) = foxes
%a = rabit growth rate
%b = fox death rate
%c,d characterize animal interactions

clear all;

a = 2*12; %[1/mo]
b = 1*12; %[1/mo]
c = 0.12; %[1/year]
d = 0.06; %[1/year]

x1 = 300;
y1 = 150;
time = 0;
tau = 1/365;

xt = x1;
yt = y1;
state = [xt,yt]; %initial population
param =[a, b, c, d];
maxstep = 1000;

for iStep=1:maxstep

foxplot(iStep) = yt;
rplot(iStep) = xt;	
tplot(iStep) = time;

time = time + tau;

state = rk4(state,time,tau,'deriveco',param);
xt = state(1);
yt = state(2);

end
figure(1)
plot(tplot,rplot,'-',tplot,foxplot,'-');

figure(2)
plot(foxplot,rplot);



% Euler's method for Lotka-Volterra equations (predator-prey system)
% dR / dt = 0.08*R -   0.001 * W * R
% dW / dt = -0.02 * W + 0.00002 * R * W
% R=rabbits, W=wolves
% Initial condition is R=300, W=40
% Plots show populations as functions of time
if 0
t0=0;
tn=1000;
W(1)=150;
R(1)=300;
tau=1;

t=t0:tau:1000;
n=max(size(t));
for i=2:n
   rPrime=R(i-1)*(0.08-0.001*W(i-1));
   wPrime=W(i-1)*(-0.02+0.00002*R(i-1));
   W(i)=W(i-1)+tau*wPrime;
   R(i)=R(i-1)+tau*rPrime;
end
figure(1)
plot(t,R)
title('Lotka-Volterra equations - rabbits population starting from R=1000')
xlabel('time')
ylabel('Rabbits')

figure(2)
plot(t,W)
title('Lotka-Volterra equations - wolves population starting from W=40')
xlabel('time')
ylabel('Wolves')

figure(3)
plot(t,R,'r',t,W,'b')
title('Lotka-Volterra equations - rabbits and wolves population starting from R=1000, W=40')
xlabel('time')

figure(4)
plot(t,R/10,'r',t,W,'b')
title('Lotka-Volterra equations - rabbits and wolves population starting from R=1000, W=40')
xlabel('time')
end
