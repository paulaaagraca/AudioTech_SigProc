function out=lin_resample(sig,speed)
% Assignment 3 - Exercise 1.2 : 
%   Interpolated delay lines for Vibrato and Flanger
%
%   Function that computes the linear interpolation of a given signal 'sig' 
%   with a resampling factor of 'speed'.
%
%   sig - input signal to resample
%   speed - resampling factor
%   out - resampled signal

out = interp1(sig,1:speed:length(sig),'linear')';

end

% With linear interpolation it is possible to listen that the transitions 
% between tones are more sharp and we can listen the low frequencies better. 
% Since the signal has less samples (for speed > 1) the high frequencies
% are affected.
%However it requires less computation