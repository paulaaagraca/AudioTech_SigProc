%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function out=vibrato(sig,f,A,fs)
% Assignment 3 - Exercise 1.3 : 
%   Interpolated delay lines for Vibrato and Flanger
%
%   Function that creates a Vibrato effect on the input signal 'sig'.
%   (if some f,A and fs inputs are not present, default values are used)
%
%   sig - input signal to apply the Vibrato effect
%   f - frequency of the delay modulation
%   A - maximum amplitude of delay in miliseconds
%   fs - sampling frequency

% default values in case of absent 
if nargin < 4, fs = 44100; end
if nargin < 3, A = 1; end
if nargin < 2, f = 5; end

% vector of length of the input signal
n = [1:length(sig)]; 

% definition of the delay in samples
del = [];
del = A*fs*1e-3*sin(2*pi*f*n./fs);

% interpolated signal with delay
out = interp1(sig,n+del,'linear');

end

% Answer: 
% If the length of the input signal is known beforehand it is possible to do it in
% real time. However if this is not the case, it is not possible because
% the delay function depends on the n (length of the input signal).
% 
% A way to do it in real time would be to use a delay buffer with a
% fixed length that adds up to the original signal by rotating itself. This
% way it would not depend on the length of the original signal.
