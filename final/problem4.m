%% kirchoff's rules

clear all;
% as Rt -> inf current ig -> 3 amps
% when Rt = 0; current ig = 8 amps

r1 = 2/3;
r2 = 10;
r3 = 2;
r4 = 9;
vg = 24;
rt = linspace(0,100,1000);
istep = length(rt);


for i=1:istep
	%% solved with equivelant resistance %%
	req1 = ((2*r4*rt(i))/((2*r4)+rt(i)));
	req2 = req1 + r3;
	req3 = req2*r2/(req2 + r2);
	rtot = req3 + 2*r1;

	%% Matrix equations %%
	%A = [(1/r1+1/r2+1/r3) -1/r3 -1/r2; 1/r3 (1/r3+1/rt(i)+1/(2*r4)) (-1/rt(i)-1/(2*r4)); 1/r1 0 1/r1];
	%b = [-vg*1/r1; 0; -vg*1/r1];
	%x = A\b;
	ig(i) = vg/rtot;
	
end 

plot(rt,ig)
ylabel('Current i (amps)');
xlabel('Variable resistor Rt \Omega');
title('current through power supply as a function of resistor Rt');

