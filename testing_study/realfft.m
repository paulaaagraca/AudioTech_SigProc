function [X,freqs]=realfft(x,fs)
% function [X,freqs]=realfft(x,fs)
%
% computes FFT for real-valued input signal and returns only non-redundant
% FFT coefficients. Optionally, the FFT bin center frequencies are returned.
%
% Inputs:
% x        input signal
% fs       sampling frequency (optional, default: 44100 [Hz])
%
% Outputs:
% X        FFT coefficients
% freqs    FFT bin center frequencies [in the same unit as fs]
%
% This function was written for the course Signal Processing for Audio
% Technology. Author: Fritz Menzer, Audio Information Processing, TUM

% handle line vectors, too
linevector=0;
if size(x,1)==1,
    x=x';
    linevector=1;
end

% compute FFT coefficients
X=fft(x);

% discard redundant coefficients
if mod(size(x,1),2)==1 % if the signal length is odd
    X=X(1:(end+1)/2,:);
else
    X=X(1:end/2+1,:);
end

% if no sampling frequency is specified, set it to 44100
if nargin<2, fs=44100; end

% compute bin center frequencies
freqs=linspace(0,fs,size(x,1)+1);
freqs=freqs(1:size(X,1));

% if input was a line vector, make output a line vector, too
if linevector
    X=X.';      % note that we have to use the non-conjugate transpose here
end