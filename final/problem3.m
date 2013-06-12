% neutron diffusion tamper
% neutrn - Program to solve the neutron diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme.
clear; help neutrn;  % Clear memory and print header

%* Initialize parameters (time step, grid points, etc.).
a = [2 4 10]; % tolorence

N = 61; %input('Enter the number of grid points: ');
g = [pi, 0, 0, 0];
for i=1:3
	L = a(i)*g(i); %critical liength is L = pi;
	% The system extends from x=-a*L/2 to x=a*L/2
	h = L/(N-1);  % Grid size	
	D = 1.;   % Diffusion coefficient
	C = 1.;   % Generation rate
	tau = .9*(h^2)/2; %% tau = .9 * (a*pi/(N-1))^2 /2
	coeff = D*tau/h^2;
	coeff2 = C*tau;

	k = linspace(0,pi,100);
	lc = g*sqrt(D/C)

	for z=1:length(k)
		count = 1;
		ll = a(i)*k(z);
		alph(z) = C*(1-(lc(i)^2 / ll^2));
		if (alph(z) > .01)
			falpha(i) = z
			g(i+1) = k(falpha(i))
			break;
		end
	end
	
	fprintf('critical length for a = %g is %g\n' , a(i), g(i+1)); 

	%%%% when |x| > L/a(i)*2 coeff2 =0; %%%%

	if( coeff < 0.5 )
  		disp('Solution is expected to be stable');
	else
  		disp('WARNING: Solution is expected to be unstable');
	end

	%* Set initial and boundary conditions.
	nn = zeros(N,1);        % Initialize density to zero at all points
	nn_new = zeros(N,1);    % Initialize temporary array used by FTCS
	nn(round(N/2)) = 1/h;   % Initial cond. is delta function in center
	%% The boundary conditions are nn(1) = nn(N) = 0

	%* Set up loop and plot variables.
	xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
	iplot = 1;                 % Counter used to count plots
	nstep = round(10/tau);
	nplots = 50;               % Number of snapshots (plots) to take
	plot_step = nstep/nplots;  % Number of time steps between plots

	%* Loop over the desired number of time steps.
	for istep=1:nstep  %% MAIN LOOP %%

		if (((sqrt(10/(.9*nstep))*(N-1))/2) > L/(a(i)*2))
			coeff2 = 0;
		end
		   	%* Compute the new density using FTCS scheme.
  	nn_new(2:(N-1)) = nn(2:(N-1)) + ...
      	coeff*(nn(3:N) + nn(1:(N-2)) - 2*nn(2:(N-1))) + ...
	   	coeff2*nn(2:(N-1));
  	nn = nn_new;        % Reset temperature to new values
  
  	%* Periodically record the density for plotting.
  		if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    		nnplot(:,iplot) = nn(:);       % record nn(i) for plotting
    		tplot(iplot) = istep*tau;      % Record time for plots
    		nAve(iplot) = mean(nn);        % Record average density 
	 		iplot = iplot+1;
	 		%fprintf('Finished %g of %g steps\n',istep,nstep);
  		end
	end
	
figure(i); clf; hold on;
mesh(tplot,xplot,nnplot);
xlabel('Time');  ylabel('x');  zlabel('n(x,t)');
title('Neutron diffusion');

figure(2*i); clf;
plot(tplot,nAve,'*');
xlabel('Time'); ylabel('Average density');
title(['L = ',num2str(L),'  (L_c = \pi)']);

end


%* Plot density versus x and t as a 3D-surface plot
figure(1); clf;
mesh(tplot,xplot,nnplot);
xlabel('Time');  ylabel('x');  zlabel('n(x,t)');
title('Neutron diffusion');

%* Plot average neutron density versus time
figure(2*i); clf;
plot(tplot,nAve,'*');
xlabel('Time'); ylabel('Average density');
title(['L = ',num2str(L),'  (L_c = \pi)']);


