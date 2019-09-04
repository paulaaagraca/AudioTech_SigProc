

fs = 44100;
%ts=1/fs;
ts=1/fs ;
T=1;
t=0:ts:T;

f_sine=fs/4;

%y=sin(2*pi*f_sine*t);
y = sawtooth(2*pi*f_sine*t, 0.5);
figure
plot(t,y)

figure
w = hann(256);
[X_s,freqs,times]=stft(y', w);
imagesc(times,freqs/1000,abs(X_s));
set(gca,'YDir','normal');