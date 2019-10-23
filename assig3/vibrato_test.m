%
% Author : Paula A A Graça
% Student @ TUM 2019
%
[x,Fs] = audioread('GitSolo.wav');
A=10;
f=5;
out=vibrato(x);
sound(out,Fs)
%audiowrite('vibrato2.wav',out,Fs)
