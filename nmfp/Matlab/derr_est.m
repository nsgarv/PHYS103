% interp - Program to interpolate data using Lagrange 
% polynomial to fit quadratic to three data points
clear all; help interp;  % Clear memory and print header
%* Initialize the data points to be fit by quadratic
disp('Enter data points as x,y pairs (e.g., [1 2])');
for i=1:3
  temp = input('Enter data point: ');
  x(i) = temp(1);
  y(i) = temp(2);
end
%* Establish the range of interpolation (from x_min to x_max)
xr = input('Enter range of x values as [x_min x_max]: ');
%* Find yi for the desired interpolation values xi using
%  the function intrpf
nplot = 100;     % Number of points for interpolation curve
for i=1:nplot
  xi(i) = xr(1) + (xr(2)-xr(1))*(i-1)/(nplot-1);
  yi(i) = intrpf(xi(i),x,y);  % Use intrpf function to interpolate
end

%* Plot the curve given by (xi,yi) and mark original data points
%plot(x,y,'*',xi,yi,'-');
%xlabel('x');
%ylabel('y');
%title('Three point interpolation');
%legend('Data points','Interpolation  ');

x0 = input('Enter an x-value to calculate derivative at that point\n>>')
p = inline('(((n - x(2)).*(n - x(3)))./((x(1) - x(2)).*(x(1) - x(3))).*y(1))...
	+ (((n - x(1)).*(n - x(3)))./((x(2) - x(1)).*(x(2) - x(3))).*y(2))...
		+((n - x(1).*(n - x(2)))./((x(3) - x(1)).*(x(3) - x(2))).*y(3))')
p(x0);

h = 1e-15;

str('p'(x)') = ((p(x0-h)-p(x0)/(h))

