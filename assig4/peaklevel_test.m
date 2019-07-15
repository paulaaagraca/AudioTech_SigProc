[x,Fs] = audioread('GitSolo.wav');
l = linspace(0,100);
%x = sin(2*pi*1000*l);
%x = 2.*l+30;
o = peaklevel(x, 0, 1, 100);

figure
plot(x)
hold
plot(o)