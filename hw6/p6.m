clear all;
format short;
fid = fopen('Mauna.txt');
M = fscanf(fid, '%g');
fclose(fid);
M = transpose(M);

fid = fopen('Barrow.txt');
B = fscanf(fid, '%g');
fclose(fid);
B = transpose(B);

xm = 1:length(M);
sigmam = .16*ones(1,length(M));
[a_fit sig_a yym chisqr] = linreg(xm,M,sigmam);
mm = (yym(length(M))-yym(1))/(xm(length(M))-xm(1));
ymten = .1*(yym(1)) + yym(1); %value of y at 10% or initial 
xmten = (ymten - yym(1))/mm; %x value at the co2 emission 10% value
fprintf('The rate of CO2 increase in Mauna Loa is %f ppm per year\n', (178/7)*mm);
tenmyr = ceil((xmten*14)/365);
fprintf('In %g years the CO2 level will be %%10 greater in Mauna Loa\n', tenmyr);

xb = 1:length(B);
sigmab = .27*ones(1,length(B));
[a_fit sig_a yyb chisqr] = linreg(xb,B,sigmab);
mb = (yyb(length(B))-yym(1))/(xb(length(B))-xb(1));
ybten = .1*(yyb(1)) + yyb(1); %value of y at 10% or initial 
xbten = (ybten - yyb(1))/mb; %x value at the co2 emission 10% value
fprintf('The rate of CO2 increase in Barrow is %f ppm per year\n', (178/7)*mb);
tenbyr = ceil((xbten*14)/365);
fprintf('In %g years the CO2 level will be %%10 greater in Barrow\n', tenbyr);

if 0
figure(1);
plot(xm,M,':',xm,yym,'r-');
title('CO2 emission in Mauna Loa, Hi');
xlabel('Day of recorded level since 1981');
ylabel('CO2 im air (ppm)');

figure(3);
plot(xm,M,':',xm,yym,'r-',xmten,ymten,'b+');
title('CO2 emission in Mauna Loa, Hi with %10 emission projection');
xlabel('Day of recorded level since 1981');
ylabel('CO2 im air (ppm)');

figure(2);
plot(xb,B,':',xb,yyb,'r-');
title('CO2 emission in Barrow, Ak');
xlabel('Day of recorded level since 1981');
ylabel('CO2 im air (ppm)');

figure(4);
plot(xb,B,':',xb,yyb,'r-',xbten,ybten,'b+');
title('CO2 emission in Barrow, Ak with %10 emission projection');
xlabel('Day of recorded level since 1981');
ylabel('CO2 im air (ppm)');
end
