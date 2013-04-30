%x = y'
%x' = (1-y^2)x - y
%from t=0 to t=10

%x1 = dxdt = y;
%x2 = dydt = -x1 + (1-x1^2)*x1;
%t0 = 1; % input('Enter initial radial distance (AU): ');  
%y0 = 1; %input('Enter initial tangential velocity (AU/yr): ');
%t = [t0 0];  y = [0 y0];
%time = 0;
%tau = .001;
%state = [ t(1) t(2) y(1) y(2) ];

%for iStep=1:10 
 % tplot(iStep) = time;
 % state = rk4(state,time,tau,'ode45');
 % t = [state(1) state(2)]; 
 % y = [state(3) state(4)];
 % time = time + tau;   
%end

function dydt = osc(t,y)
	dydt = zeros(2,1);
	dydt(1) = y(2);
	dydt(2) = (1-y(1)^2)*y(2) - y(1);
end

function [T,Y] = call_osc()
	tspan = [0 10];
	y1_0 = 1;
	y2_0 = 1;
	[T,Y] = ode15s(@osc,tspan,[y1_0 y2_0]);
	plot(T,Y(:,1),'o');
end
