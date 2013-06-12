%% kirchoff's rules

clear all;
% as Rt -> inf current ig -> 3 amps
% when Rt = 0; current ig = 8 amps

r1 = 2/3;
r2 = 10;
r3 = 2;
r4 = 9;
vg = 24;
rv = linspace(0,100,100);
istep = length(rv);


for i=1:istep
	rt = rv(i);
	%% solved with equivelant resistance %%
	%if 0
	req1 = ((2*r4*rt)/((2*r4)+rt));
	req2 = req1 + r3;
	req3 = req2*r2/(req2 + r2);
	rtot = req3 + 2*r1;
	%end 

	%% Matrix equations %%
	%A=[2*r1+r2/2 -r2/2 -r2/2; -r2/2+r3/2+rt/2 r2+r3+rt/2 r2+r3+rt; -rt/2 -rt/2 -rt/2+2*r4];
	%A = [(1/r1+1/r2+1/r3)*vg -1/r3 -1/r2; 1*vg/r3 (1/r3+1/rt+1/(2*r4)) (-1/rt-1/(2*r4)); 1*vg/r1 0 1/r1];
	%b = [vg; 0; 0];
	%b = [0; 0; 0];
	%x = A\b;
	%ig(i) = x(1)/r1;
	ig(i) = vg/rtot;
	%ig(i) = x(1)
	
end 

plot(rv,ig);
ylabel('Current i (amps)');
xlabel('Resistance resistor Rt \Omega');
title('current through power supply as a function of resistor Rt');

