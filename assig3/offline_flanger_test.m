[sig,Fs] = audioread('GitHarmony.wav');
M0 = 10;
a = 5;
f = 1;
g = 3;

out=offline_flanger(sig,M0,a,f,g,Fs);

sound(out,Fs)
%audiowrite('vibrato2.wav',out,Fs)