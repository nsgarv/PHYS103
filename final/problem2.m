% use the method of least squares to generate a polynomial p(x)
% that best approximates f(x) = sin(pi*x)
clear all; help problem2;

x = linspace(0,1,100);
fx = sin(pi*x);

plot(x,fx);

A = ([ones(size(x)), x1, x2]);

y1 = -x^3/3;
y2 = -x^2/2;
y3 = -x;
