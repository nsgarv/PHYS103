if 0
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
%first dimension is x and teh second is t
Timag(:,:,1)=(ones(length(x),1)*(1./sig)).*exp(-(x'-L/4).^2*(1./sig.^2)/2)/sqrt(2*pi);
%(ones(length(x),1)*(1./sig)) is a matrix of size (x,t)
for ii=1:nimag                                                               
	Timag(:,:,ii+1)=Timag(:,:,ii)+(ones(length(x),1)*(1./sig)).*exp(-(x-(L/4)-ii*L)'.^2*((1./sig.^2)/2))/sqrt(2*pi)+(ones(length(x),1)*(1./sig))...
	.*exp(-(x-(-L/4+ii*L))'...
	.^2*((1./sig.^2)/2))/sqrt(2*pi);
end
%figure(1)
mesh(t,x,Timag(:,:,nimag));
title('maxs way');
end

%if 0
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
%first dimension is x and teh second is t
Timag(:,:,1)=(ones(length(x),1)*(1./sig)).*exp(-(x'-L/4).^2*(1./sig.^2)/2)/sqrt(2*pi);
%(ones(length(x),1)*(1./sig)) is a matrix of size (x,t)
for ii=1:nimag                                                               
	Timag(:,:,ii+1)=Timag(:,:,ii)+(ones(length(x),1)*(1./sig)).*exp(-(x+(tan((ii*pi)/2)+cos((ii*pi)/2))*(L*(2*ii-1)/4))'.^2*((1./sig.^2)/2))/sqrt(2*pi)+(ones(length(x),1)*(1./sig))...
	.*exp(-(x-(tan((ii*pi)/2)+cos((ii*pi)/2))*(L*(2*ii-1)/4))'...
	.^2*((1./sig.^2)/2))/sqrt(2*pi);
end
mesh(t,x,Timag(:,:,nimag));
title('sines and cosines');
%end

