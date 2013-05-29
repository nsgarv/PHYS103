if 0
F1 = k1*x1 + k2*x2 - k1*l - k2*l;
F2 = -2*k1*x1 - k2*x1 + k1*x2 + k2*x3 + k1*l - k2*l - k1*l;
F3 = k1*x1 - 2*k1*x2 + k1*x3 + k1*l - k1*l + k2*l;
F4 = k2*x1 + k1*x2 - k1*x3 - k2*x3 + k1*l + k2*l;
end

clear all

k = input('k2 is function of k1. Input spring constant k=[k1 k2]: ');
j=logspace(1/1000,1000,50);

for (h = 1:length(j))
	%k2 goes from k1/1000 to 1000*k1;
	k(2) = j(h)*k(1);

	L = 1 %input('Enter rest lengths L=[L1 L2 L3 L4]: ');
	%kk=[-k(1)-k(2) k(2) 0;k(2) -k(2)-k(3) k(3);0 k(3) -k(3)-k(4)];
	%b=[-k(1)*L(1)+k(2)*L(2) -k(2)*L(2)+k(3)*L(3) -k(3)*L(3)+k(4)*(L(4)-Lw)]';

	kk = [-2*k(1)-k(2) , k(1) , k(2); k(1) , -2*k(1) , k(1); k(2) , k(1) , -k(1)-k(2)];
	b = [k(2); -k(2); -k(1)-k(2)];
	x=kk\b; %same as x=inv(kk)*b
	length(h) = sum(x);
	yplot(h) = k(1)/k(2);
	%disp('Positions of the masses are ');
	%disp(x');
end

semilogx(length, yplot);

%matrix is singular so it cant be inverted. Need to make the origin at block 1. stuck here


