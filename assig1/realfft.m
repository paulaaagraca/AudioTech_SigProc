function [X,freqs]=realfft(x,fs)

fN = fs/2;
N=512;

F = fft(x,N);
%f = fN*linspace(0,1,N/2);
X = abs(F(1:N/2));
[pks,freqs] = findpeaks(X,'MinPeakHeight', 20);
%freqs not correct


for i=1:N
    if x(i)>200
    freqs = [freqs x(i)];
    end
end
end 