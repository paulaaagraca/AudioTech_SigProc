%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function out=offline_flanger(sig,M0,a,f,g,fs)
% Assignment 3 - Exercise 1.4 :
%   Offline Flanger
%
%   sig - input signal to apply the Vibrato effect
%   M0  - average delay in samples
%   a   - maximum delay swing
%   f   - rate in cycles/sec
%   g   - depth of the effect
%   fs  - sampling frequency

% in case not all parameters are inserted
if nargin < 6, fs = 44100; end
if nargin < 5, g = 3; end
if nargin < 4, f = 1; end
if nargin < 3, a = 5; end
if nargin < 2, M0 = 10; end

%initialize n vetor of sig's size
n = [1:length(sig)];

% delay variation M
M = [];
M = M0*(1+a*sin(2*pi*f*n/fs));

% sig + delay M samples
aux = interp1(sig,n+M,'linear')';
% add delayed signal with original sig (depth g is compensated)
out = aux*g + sig*(1-g);

end
