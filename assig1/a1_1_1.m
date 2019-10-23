%
% Author : Paula A A Graça
% Student @ TUM 2019
%

aPR = init_aPR;

n=512;
fs = 44100;
time = 1; % sec
low_lim = -1;
high_lim = 1;

%interval [-1,1]
%time*fs num of lines, 2 collumns (44100 samples in 1 sec)
signal = (high_lim - low_lim).*rand(time*fs,2)-high_lim;
[~] = aPR(signal);
