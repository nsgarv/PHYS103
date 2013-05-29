clear all;

fid = fopen('Mauna.txt');
M = fscanf(fid, '%g');
fclose(fid);
M = transpose(M)

fid = fopen('Barrow.txt');
B = fscanf(fid, '%g');
fclose(fid);
B = transpose(B);

xm = 1:length(M);
sigmam = .16*ones(1,length(M));

xb = 1:length(B);
sigmab = .27*ones(1,length(B));

figure(1);
plot(xm,M,':');
title('CO2 emission in Mauna Loa, Hi');

figure(2);
plot(xb,B,':');
title('CO2 emission in Barrow, Ak');
