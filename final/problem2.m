% use the method of least squares to generate a polynomial p(x)
% that best approximates f(x) = sin(pi*x)
clear all; help problem3;

x = linspace(0,1,100);
fx = sin(pi*x);

plot(x,fx);

