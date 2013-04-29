z = 1;
for i=2:300
	if (rplot(i)>(rplot(i-1)) && rplot(1)<rplot(i+1))
		rmax(z) = rplot(i);
		z = z + 1;
	end
end
