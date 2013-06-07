
%%% Part A %%%
%if 0
% 1D diffusion equation
kappa=1;
L=1;
t=[1e-4:1e-4:.03];
x=[-(1/2)*L:0.01:(1/2)*L];
% Method of images
sig=sqrt(2*kappa*t); %definition of sigma
TG=zeros(length(x),length(t));
nimag=10;
Timag=zeros([size(TG) nimag+1]);
%%central gaussian
%first dimension is x and the second is t
Timag(:,:,1)=(ones(length(x),1)*(1./sig)).*exp(-(x').^2*(1./sig.^2)/2)/sqrt(2*pi);
%(ones(length(x),1)*(1./sig)) is a matrix of size (x,t)
for ii=1:nimag                                                               
	Timag(:,:,ii+1)=Timag(:,:,ii)+(-1)^ii*(ones(length(x),1)*(1./sig))...
	.*exp(-(x+(ii*L/2))'.^2*((1./sig.^2)/2))/sqrt(2*pi)+(-1)^ii*(ones(length(x),1)*(1./sig))...
	.*exp(-(x-(ii*L/2))'.^2*((1./sig.^2)/2))/sqrt(2*pi);
end
%figure(1)
mesh(t,x,Timag(:,:,nimag));
title('part a');

% dftcs - Program to solve the diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme.
clear; help dftcs;  % Clear memory and print header

%* Initialize parameters (time step, grid spacing, etc.).
tau = 1e-4; %input('Enter time step: ');
N = 61; %input('Enter the number of grid points: ');
L = 1.;  % The system extends from x=-L/2 to x=L/2
h = L/(N-2);  % Grid size
kappa = 1.;   % Diffusion coefficient
coeff = kappa*tau/(h^2);
if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

%* Set initial and boundary conditions.
tt = zeros(N,1);          % Initialize temperature to zero at all points
tt(round(N/2)) = 1/h;     % Initial cond. is delta function in center
%% The boundary conditions are tt(1) = tt(N) = 0

%* Set up loop and plot variables.
xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 300;               % Maximum number of iterations
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots

%* Loop over the desired number of time steps.
for istep=1:nstep  %% MAIN LOOP %%

  %* Compute new temperature using FTCS scheme.
  tt(2:(N-1)) = tt(2:(N-1)) + ...
      coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
  
  %* Periodically record temperature for plotting.
  if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    ttplot(:,iplot) = tt(:);       % record tt(i) for plotting
    tplot(iplot) = istep*tau;      % Record time for plots
    iplot = iplot+1;
  end
end

%* Plot temperature versus x and t as wire-mesh and contour plots.
figure(1); clf;
mesh(tplot,xplot,ttplot);  % Wire-mesh surface plot
xlabel('Time');  ylabel('x');  zlabel('T(x,t)');
title('Diffusion of a delta spike');
pause(1);
figure(2); clf;       
contourLevels = 0:0.5:10;  contourLabels = 0:5;     
cs = contour(tplot,xplot,ttplot,contourLevels);  % Contour plot
clabel(cs,contourLabels);  % Add labels to selected contour levels
xlabel('Time'); ylabel('x');
title('Temperature contour plot');

%plot(xplot, ttplot(:,round(N/2)))


%end

if 0
%%% Part B %%%
% 1D diffusion equation
% analytical solution
kappa=1;
L=1;
t=[1e-4:1e-4:.03];
x=[-(1/2)*L:0.01:(1/2)*L];
% Method of images
sig=sqrt(2*kappa*t); %definition of sigma
TG=zeros(length(x),length(t));
nimag=10;
Timag=zeros([size(TG) nimag+1]);
%%central gaussian
%first dimension is x and the second is t
Timag(:,:,1)=(ones(length(x),1)*(1./sig)).*exp(-(x'-L/4).^2*(1./sig.^2)/2)/sqrt(2*pi);
%(ones(length(x),1)*(1./sig)) is a matrix of size (x,t)
for ii=1:nimag                                                               
	Timag(:,:,ii+1)=Timag(:,:,ii)+(ones(length(x),1)*(1./sig))...
	.*exp(-(x+(tan((ii*pi)/2)+cos((ii*pi)/2))*(L*(2*ii-1)/4))'.^2*((1./sig.^2)/2))...
		/sqrt(2*pi)+(ones(length(x),1)*(1./sig))...
	.*exp(-(x-(tan((ii*pi)/2)+cos((ii*pi)/2))*(L*(2*ii-1)/4))'.^2*((1./sig.^2)/2))...
		/sqrt(2*pi);
end
figure(1)
mesh(t,x,Timag(:,:,nimag));
title('Tan and cos');

%Numerial solution
% dftcs - Program to solve the diffusion equation 
% using the Forward Time Centered Space (FTCS) scheme.
clear; help dftcs;  % Clear memory and print header

%* Initialize parameters (time step, grid spacing, etc.).
tau = 1e-4; %input('Enter time step: ');
N = 61; %input('Enter the number of grid points: ');
L = 1.;  % The system extends from x=-L/2 to x=L/2
h = L/(N-2);  % Grid size
kappa = 1.;   % Diffusion coefficient
coeff = kappa*tau/(h^2);
if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

%* Set initial and boundary conditions.
tt = zeros(N,1);          % Initialize temperature to zero at all points
tt(round(3*N/4)) = 1/h;     % Initial cond. is delta function in center
%% The boundary conditions are tt(1) = tt(N) = 0

%* Set up loop and plot variables.
xplot = (0:N-1)*h -h/2 - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
nstep = 300;               % Maximum number of iterations
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots

%* Loop over the desired number of time steps.
for istep=1:nstep  %% MAIN LOOP %%

  %* Compute new temperature using FTCS scheme.
  tt(2:(N-1)) = tt(2:(N-1)) + ...
      coeff*(tt(3:N) + tt(1:(N-2)) - 2*tt(2:(N-1)));
  
  %* Periodically record temperature for plotting.
  if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    ttplot(:,iplot) = tt(:);       % record tt(i) for plotting
    tplot(iplot) = istep*tau;      % Record time for plots
    iplot = iplot+1;
  end
end

%* Plot temperature versus x and t as wire-mesh and contour plots.
figure(2); clf;
mesh(tplot,xplot,ttplot);  % Wire-mesh surface plot
xlabel('Time');  ylabel('x');  zlabel('T(x,t)');
title('Diffusion of a delta spike');
pause(1);
figure(3); clf;       
contourLevels = 0:0.5:10;  contourLabels = 0:5;     
cs = contour(tplot,xplot,ttplot,contourLevels);  % Contour plot
clabel(cs,contourLabels);  % Add labels to selected contour levels
xlabel('Time'); ylabel('x');
title('Temperature contour plot');


plot(xplot, ttplot(:,round(N/2)))
end

