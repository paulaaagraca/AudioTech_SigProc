function out=offline_dynproc(sig,cr,lim_thr,comp_thr,gate_thr,t_AP,t_RP,t_AS,t_RS,t_delay,fs)
% Assignment 4 - Exercise 3.5 
%   Offline implementation of a dynamic processor
%
%   sig - linear input
%   cr - compression ration
%   lim_thr - limiting threshold
%   comp_thr - compression threshold
%   gate_thr - gate threshold
%   t_AP - attack time (ms)
%   t_RP - release time (ms)
%   t_AS - attack time (ms)
%   t_RS - release time (ms)
%   t_delay - delay of input signal (ms)
%   fs - sampling frequency

     % set default sampling frequency
    if nargin<11, fs=44100; end           
    
    %number of delay samples
    D = t_delay*0.001*fs;
    
    %calculate delay vector for D samples
    for n = 1:length(sig)
        if n > D
            del(n) = sig(n-D);
        else
            del(n) = 0;
        end 
    end
    % peak level estimation 
    level_estimated = peaklevel(sig, 0, t_AP, t_RP);
    % apply static curve for linear gain
    static_gain = staticgain(level_estimated, cr, lim_thr, comp_thr, gate_thr);
    % gain smoothing
    g = gainsmooth(static_gain, 0, t_AS, t_RS);
    
    %apply delay vector to processed signal g
    out = del.*g;
end