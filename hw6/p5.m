clear all;

DJA = [2471 2510 2410 2350 2240];
x = [1 2 3 4 5];
y = DJA;

	
	sigma = ones(1,length(x));
	[a_fit5 sig_a yy5 chisqr] = pollsf(x,y,sigma,5);
	x(6) = 6;
	yy5(6) = a_fit5(1) + a_fit5(2)*x(6) + a_fit5(3)*x(6)^2 + a_fit5(4)*x(6)^3 + a_fit5(5)*x(6)^4;
	plot(x,yy5,'g-o');
	hold on;

DJAi = [2471 2510 2410 2350 2240];
xi = [1 2 3 4 5];
yi = DJA;

	for M=1:5
		sigma = ones(1,length(xi));
		[a_fit sig_a yy chisqr] = pollsf(xi,yi,sigma,M);
		plot(xi,(yy),'b-o',xi,yi,'r-+');
		hold on;
	end

