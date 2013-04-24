clear all;

x = [0 2 -1 1];
y = [0 1 1 0];
%disp('Enter four control points for x and y');
%disp('The format should be: [x1 x2 x3 x4] <enter>');
%disp('and [y1 y2 y3 y4] <enter>');
%nx = input('Enter x vctor\n>>');
%ny = input('Enter y vector\n>>');

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
y1 = y(1);
y2 = y(2);
y3 = y(3);
y4 = y(4);

cx = (x2 - x1)*3
bx = (x3 - x2)*3 - cx
ax = x4 - x1 - cx - bx

cy = (y2 - y1)*3
by = (y3 - y2)*3 - cy
ay = y4 - y1 - cy - by

for i=0:1/3:1
	X(i*3+1) = ax*(i)^3 + bx*(i)^2 + cx*(i) + x1;
	Y(i*3+1) = ay*(i)^3 + by*(i)^2 + cy*(i) + y1;
end

X;
Y;
plot(X,Y,'bo', x,y, 'g-')





%x(t) = axt^3 + bxt^2 + cxt + x1
%y(t) = ayt^3 + byt^2 + cyt + y1

%x2 = x1 + cx/3;
%x3 = x2 + (cx + bx)/3;
%x4 = x1 + cx + bx + ax;

%y2 = y1 + cy/3;
%y3 = y2 + (cy + by)/3;
%y4 = y1 + cy + by + ay;

%(x(0),y(0)) = (x1,y1); to (x(1),y(1)) = (x4,y4)
%(x1,y1)-(x2,y2)