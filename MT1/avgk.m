function kinetplot = avgk(theta,kinetic)

a = length(theta);
val = zeros(20,1);
n=1;
for(istep=1:a)
	if(theta > 6)
		val(n) = istep
		pause(.25);
		n = n+1;  
	end
end



kinetplot = val;
return;