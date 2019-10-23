%
% Author : Paula A A Graça
% Student @ TUM 2019
%
[x,Fs] = audioread('GitSolo.wav');

l = linspace(0,100);
%x = sin(2*pi*1000*l);
%x = 2.*l+30;
gain = staticgain(x, 1, -30, -40, -50);
o = gainsmooth(gain, 1, 1, 100);
v = o'.*x;
figure
plot(x)
hold
plot(v)
