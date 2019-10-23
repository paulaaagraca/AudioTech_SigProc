%
% Author : Paula A A Graça
% Student @ TUM 2019
%
[sig,fs] = audioread('AIP_Song.wav');

v = offline_dynproc(sig, 10, -20,    -30,     -80,     2,   500, 100, 300, 0,      fs);
%out=offline_dynproc(sig,cr,lim_thr,comp_thr,gate_thr,t_AP,t_RP,t_AS,t_RS,t_delay,fs)
out = v.*sig';

figure
plot(sig)
hold
plot(v)
sound(sig,fs)
