function out=spline_resample(sig,speed)
% Assignment 3 - Exercise 1.1 : 
%   Interpolated delay lines for Vibrato and Flanger
%
%   Function that computes the spline interpolation of a given signal 'sig' 
%   with a resampling factor of 'speed'.
%
%   sig - input signal to resample
%   speed - resampling factor
%   out - resampled signal

out = interp1(sig,1:speed:length(sig),'spline')';

end

% With spline interpolation it is possible to listen that the transitions 
% between are tones are smoother than in linear interpolation. Since the
% signal has less samples (for speed > 1) the high frequencies are affected 
% and the low frequencies are better listened.
