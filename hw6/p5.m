clear all;
DJA = [2471 2510 2410 2350 2240];

x = [1 2 3 4 5];


y = DJA;
for M=1:5
	if M>2
		yinterp(M) = intrpf(M+1,x(1:M),y(1:M));
	end
	sigma = ones(1,length(x));
	[a_fit sig_a yy chisqr] = pollsf(x,y,sigma,M);
	plot(x,(yy),'b-o',x,y,'r-+');
	hold on;
end
if 0
figure(2);
plot((x+1),yinterp,'--g');
end