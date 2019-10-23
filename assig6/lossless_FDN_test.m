%
% Author : Paula A A Graça
% Student @ TUM 2019
%
sig = zeros(4*fs,1);
sig(1) = 1;
out = lossless_FDN(sig,0.5,16,0.5,44100);

figure
plot(out)
hold on
plot(sig)
