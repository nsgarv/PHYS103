% use the method of least squares to generate a polynomial p(x)
% that best approximates f(x) = sin(pi*x)
clear all; help problem2;

x = linspace(0,1,100);

A = [2/5 1/2 2/3; 1/2 2/3 1; 2/3 1 2];
y = [(2/pi - 8/(pi^3)); 2/pi; 4/pi];

a = A\y

for i=1:length(x)
	px(i) = a(1)*x(i)^2 + a(2)*x(i) + a(3);
	fx(i) = sin(pi*x(i));
end

clf;
plot(x,px,'--',x,fx,'-')
ylabel('f(x) = sin(\pi x) and p(x)');
xlabel('xplot');
legend('p(x)','sin(\pi x)');
title('quadratic apprximation of sin(\pi x)');