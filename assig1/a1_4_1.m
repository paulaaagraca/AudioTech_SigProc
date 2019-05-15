t = 0:0.01:(2*pi);
fs=44100;
x = sin(t*10)+cos(t*200);
[X,freqs]=realfft(x,fs);

plot(X)