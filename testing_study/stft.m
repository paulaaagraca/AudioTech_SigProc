function [X,freqs,times]=stft(x, w, overlap, fs, N)
% function [X,freqs,times]=stft(x, w, overlap, fs, N)
%
% Compute Short Time Fourier Transform (STFT) of a signal.
% (with support for zero padding)
%
% Inputs:
% x        signal
% w        window function (default: raised cosine window of length 512)
%          if w is a scalar, a raised cosine window of length w is used.
% overlap  overlap in samples (default: length(w)/2)
%          if abs(overlap)<1, it is interpreted as a fraction of the window
%          size; if overlap<0, it is interpreted as the step size.
% fs       sampling frequency (default: 44100 [Hz])
% N        FFT length (optional, default: length(w))
%
% Outputs:
% X        STFT coefficients (rows: frequency bins, columns: time steps)
% freqs    Frequency bin center frequencies [same unit as fs]
% times    Frame center times [inverse of unit of fs]
%
% This function was written for the course Signal Processing for Audio
% Technology. Author: Fritz Menzer, Audio Information Processing, TUM

% if no window was specified, use a 512 sample raised cosine window
if nargin<2, w=0.5+0.5*cos((-255.5:255.5)/256*pi)'; end

% if w is a scalar, generate raised cosine window of length w
if length(w)==1, w=0.5+0.5*cos((-w/2+0.5:w/2-0.5)/w*2*pi)'; end

% if no overlap was defined, set it to half the window length
if nargin<3, overlap=floor(length(w)/2); end

% if overlap is smaller than 1, interpret it as a fraction
if abs(overlap)<1, overlap=round(length(w)*overlap); end

% if overlap is negative, interpret it as step size
if overlap<0, overlap=length(w)+overlap; end

% if sampling frequency was not defined, use 44100 [Hz]
if nargin<4, fs=44100; end

% if FFT length was not specified, set it to window length
if nargin<5, N=length(w); end

% determine frequency bin center frequencies
[X,freqs]=realfft(zeros(N,1),fs);

M = length(w);                      % M = window length, N = FFT length
R = M-overlap;                      % step size

% zero-pad signal in the beginning and the end
x=[zeros(R,1); x; zeros(R,1)];

nframes=floor((length(x)-overlap)/R); % number of frames
X = zeros(length(freqs),nframes);   % pre-allocate STFT output array
zp = zeros(N-M,1);                  % zero padding (to be inserted)
xoff = 0;                           % current offset in input signal x
for m=1:nframes
  xt = x(xoff+1:xoff+M);            % extract frame of input data
  xtw = w .* xt;                    % apply window to current frame
  xtwz = [xtw; zp];                 % windowed, zero padded
  X(:,m) = realfft(xtwz);           % FFT for frame m
  xoff = xoff + R;                  % advance in-pointer by hop-size R
end

% determine frame center times
times=(0:nframes-1)*R/fs;