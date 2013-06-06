% advect - Program to solve the advection equation 
% using the various hyperbolic PDE schemes
clear all;  help advect;  % Clear memory and print header

%* Select numerical parameters (time step, grid spacing, etc.).
N = 61; % number of grid points
L = 1.;     % System size
h = L/N;    % Grid spacing
kappa = 1.; % kappa
tau = 1e-4; % time step
coeff = -kappa*tau/(2.*h);  % Coefficient
nStep = 1000; % number of steps
tt = linspace(1e-4,.03, nStep);

%* Set initial and boundary conditions.
%sigma = .1;
sigma = sqrt(2*kappa.*tt);              % Width of the Gaussian pulse
x = ((1:N)-1/2)*h - L/2;  % Coordinates of grid points
% Initial condition is a Gaussian-cosine pulse
a = (ones(length(x),1)*(1./sigma)).*exp(-(x'-L/4).^2*(1./sigma.^2)/2)/sqrt(2*pi);
% Use periodic boundary conditions
ip(1:(N-1)) = 2:N;  ip(N) = 1;   % ip = i+1 with periodic b.c.
im(2:N) = 1:(N-1);  im(1) = N;   % im = i-1 with periodic b.c.

%* Initialize plotting variables.
iplot = 1;          % Plot counter
aplot(:,1) = a(:);  % Record the initial state
%tplot(1) = 0;       % Record the initial time (t=0)
tplot = tt;
nplots = 1000;        % Desired number of plots
plotStep = nStep/nplots; % Number of steps between plots

%* Loop over desired number of steps.
k = 1;
for iStep=1:nStep  %% MAIN LOOP %%
	k = k+1;
  %* Compute new values of wave amplitude using FTCS, 
   %%% FTCS method %%%
    a(1:k) = a(1:k) + coeff*(a(ip)-a(im));  
  end   

  %* Periodically record a(t) for plotting.
  if( rem(iStep,plotStep) < 1 )  % Every plot_iter steps record 
    iplot = iplot+1;
    aplot(:,iplot) = a(:);       % Record a(i) for ploting
    tplot(iplot) = tau*iStep;
    fprintf('%g out of %g steps completed\n',iStep,nStep);
  end

%* Plot the initial and final states.
if 0
figure(1); clf;  % Clear figure 1 window and bring forward
plot(x,aplot(:,1),'-',x,a,'--');
legend('Initial  ','Final');
xlabel('x');  ylabel('a(x,t)');
pause(1);    % Pause 1 second between plots
end

%* Plot the wave amplitude versus position and time
figure(2); clf;  % Clear figure 2 window and bring forward
mesh(tplot,x,aplot);
ylabel('Position');  xlabel('Time'); zlabel('Amplitude');
view([-70 50]);  % Better view from this angle



if 0
% 1D diffusion equation
kappa=1;
L=1;
t=[1e-8 0.01:0.01:1];
x=[-3/2*L:0.01:3/2*L];
% Method of images
sig=sqrt(2*kappa*t); %definition of sigma
TG=zeros(length(x),length(t));
nimag=20;
Timag=zeros([size(TG) nimag+1]);
%%central gaussian
%first dimension is x and teh second is t
Timag(:,:,1)=(ones(length(x),1)*(1./sig)).*exp(-x'.^2*(1./sig.^2)/2)/sqrt(2*pi);
%(ones(length(x),1)*(1./sig)) is a matrix of size (x,t)
for ii=1:nimag                                                               
	Timag(:,:,ii+1)=Timag(:,:,ii)+(-1)^ii*(ones(length(x),1)*(1./sig)).*exp(-(x+ii*L)'.^2*(1./sig.^2)/2)/sqrt(2*pi)+...
    	(-1)^ii*(ones(length(x),1)*(1./sig)).*exp(-(x-ii*L)'.^2*(1./sig.^2)/2)/sqrt(2*pi);
end
% Separation of variables
n=20;
T=zeros([size(TG) n+1]);
T(:,:,1)=2/L*sin(pi/L*(x'+L/2))*exp(-(pi/L)^2*kappa*t);    
for ii=3:2:2*n+1
	T(:,:,(ii+1)/2)=T(:,:,(ii-1)/2)+(-1)^((ii-1)/2)*2/L*sin(ii*pi/L*(x'+L/2))*exp(-(ii*pi/L)^2*kappa*t);    
end
% Matrix Stability Analysis for FTCS for thermal diffusion
Ngrid=61;
h=L/(Ngrid-1); 
%tsig=h^2/2/kappa;
tsig=1;
tstep=logspace(-2,2,11);
D=zeros(Ngrid);
for ii=2:Ngrid-1
    D(ii,ii)=-2;
    D(ii,ii-1)=1;
    D(ii,ii+1)=1;
end
nPower=20;
rho=zeros(size(tstep));
rho_eig=zeros(size(tstep));
for it=1:length(tstep)
A=eye(Ngrid)+tstep(it)/2/tsig*D;
%rho(it)=abs(poweig(A,nPower));
rho_eig(it)=max(abs(eig(A)));
end
loglog(tstep,rho_eig,'*',tstep,rho,'o',tstep,ones(1,length(tstep)),'--')
xlabel('Time step'); ylabel('Spectral radius')
legend('MATLAB eig','Power method')
end