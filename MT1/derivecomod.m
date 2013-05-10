function deriv = derivecomod(s,t,param);

%s = the state. s(1) is dx, s(2) is dy.
%select constants 
a = param(1);
b = param(2);
c = param(3);
d = param(4);
x = s(1);
y = s(2);
k = 1000;

%set up differential equations 

deriv(1) = (a * (1 - x/k) - c * x * y);
%pause(.25)
deriv(2) = (-b * y + d * x * y);
%pause(.25)
deriv = [deriv(1), deriv(2)];
return;