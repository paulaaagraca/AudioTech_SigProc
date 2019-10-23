%
% Author : Paula A A Graça
% Student @ TUM 2019
%
sig = zeros(4*fs,1);
sig(2) = 1;

out=filter_FDN(y,0.5,16,1,2,44100);

figure
plot(out)
hold on
plot(sig)

sound(out,fs)
