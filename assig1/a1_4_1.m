%
% Author : Paula A A Graça
% Student @ TUM 2019
%
t = 0:0.01:(2*pi);
fs=44100;
x = sin(t*10)+cos(t*200);
[X,freqs]=realfft(x,fs);

plot(X)
