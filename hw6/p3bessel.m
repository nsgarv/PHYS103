%Bonusquestion:
%An“exact”formulaforEisknown: 
%E=M 2∑+ 1Jj(jε)sin(jM),where j=1 j Jj (x) is the Bessel function of the first kind of order j. 
%Use this formula, and besselj(m,x) in Matlab, to compute E. 
%How many terms are needed for the two eccentricity values, 
%so that the relative error is less than 10-4. 
%Plot both numerical and theoretical solutions on the same graphs.

if 0
	One way to do the bonus is to create a matrix with dimensions of # of 
	plotting points x # of Bessel functions in your sum.
	j is the Bessel function order (which also enters its 'x' value), 
	epsilon is the eccentricity parameter. Then the first row will be E(M)
	with one term in the sum, the second row will include two terms, and so on. 
	You can then compare this analytic result to your numeric, and see how many 
	terms are necessary for convergence.
end

x = zeros[100,10];
count = 100;
ecc = [.1 .2 .3 .4 .5 .6 .7 .8 .9];
M = linspace(0,2*pi,count);



% f(E) = M - E + e * sin(E)

