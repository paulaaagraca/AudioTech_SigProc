%
% Author : Paula A A Graça
% Student @ TUM 2019
%
t_fadein = 100;
t_fadeout = 100;
fs = 44100;

x = ones(2*fs,1);
out=exp_fade(x,-10,t_fadein,t_fadeout,fs);

figure
plot(out)

%sound(out,fs)
