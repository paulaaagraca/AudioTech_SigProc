%
% Author : Paula A A Graça
% Student @ TUM 2019
%
[sig,Fs] = audioread('AIP_Song.wav');
%player = audioplayer(sig(1:600000), Fs);
%play(player);
speed = 0.5 ;
out=spline_resample(sig,speed);
sound(out,Fs/speed)
%player = audioplayer(out, Fs);
%play(player);
