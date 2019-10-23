%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function [h]= inverse_FIR_design(G,N)
% Assignment 2 - Exercise 2.1 : 
%   Linear phase FIR filter design
%
%   Function inverts a given frequency response G, with length of 2N+1
%
%   G : output of the real-valued FFT
%       resolution of 1025 samples; IFFT has 2049 samples in time domain
%   h : linear phase impulse response with length of 2N+1
%       h(t) --FFT--> H(f)=1/G(f)
%

H=1./G';
n_samp_time = 2049;

% IFFT of G
h1 = real(ifft(H,n_samp_time));
% initialize auxiliar vector with size 2N+1
vector = zeros(1,2*N+1);

% Case 1 - first N+1 concatenated with the last N of the IFFT output
% vector(1:N+1) = h1(1:N+1)                          % N+1
% vector(N+2:2*N+1) = h1(length(h1)-N+1:length(h1))  % N

% Case 2 - using fftshift.m and extract the middle 2N+1 samples
h2 = fftshift(h1);
vector(1:N+1) = h2(ceil(length(h2)/2)-N:ceil(length(h2)/2));        % N+1
vector(N+2:2*N+1) = h2(ceil(length(h2)/2)+1:ceil(length(h2)/2)+N);  % N

h = vector;
