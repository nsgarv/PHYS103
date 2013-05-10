function kinetplot = avgk(thplot,kinetic)

a = length(thplot);
t = abs(thplot);

n=1;
istep = 1;
while (istep < a)
	if(t(istep) < .23)
		val(n) = istep;
		n = n+1;  
		istep = istep + 1;
	end
end



%kinetplot = [];
return;