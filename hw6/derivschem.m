function deriv = deriveco(s,t,param);

%s = the state. s(1) is dx, s(2) is dy.
%select constants 
A = param(1);
B = param(2);


x = s(1);
y = s(2);

%set up differential equations 

deriv(1) = A + (x^2) * y - (B+1) * x;
%pause(.25)
deriv(2) = B * x - (x^2) * y;
%pause(.25)
deriv = [deriv(1), deriv(2)];
return;