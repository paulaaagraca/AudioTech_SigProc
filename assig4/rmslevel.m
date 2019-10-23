%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function rms=rmslevel(sig, lastRMS, t_AR, fs)
% Assignment 4 : Exercise 3.3
%   RMS level estimation 
%
%   sig - linear input levels
%   lastRMS - last calculated value of RMS
%   t_AR - averaging time (ms)
%   fs - sampling frequency

    % set default sampling frequency
    if nargin<4, fs=44100; end
    
    % initialize auxiliar vector
    aux_rms = [];
    
    % calculate AV
    aux_AV = -2197/(t_AR*fs);
    AV = 1-exp(aux_AV);
    
    %sample-wise RMS estimation
    for n = 1:length(sig)
        % current sample
        sample = sig(n);
        
        %__________computation of RMS estimation block diagram__________
        x_2 = sample*sample;
        aux1 = x_2-lastRMS;
        aux2 = AV*aux1;
        x_2RMS = aux2+lastRMS;
        %update RMS for next sample computation
        lastRMS = x_2RMS;
        %output value of the current interation
        xRMS = sqrt(abs(x_2RMS));
        % output vector
        aux_rms = [aux_rms; xRMS];
        %_______________________________________________________________
    end
    % total output
    rms = aux_rms;
end
