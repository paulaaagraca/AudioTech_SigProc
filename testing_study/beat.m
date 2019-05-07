t = 0:0.01:(2*pi);
f1 = cos(t*180);
f2 = cos(t*220);

f = f1 + f2;
figure
subplot(2,1,1)
plot (t,f)
axis([0 2*pi -2 2])
legend('f')

fourier = fft(f);
subplot(2,1,2)
plot(t,fourier)