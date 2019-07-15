function p=peaklevel(sig, lastP, t_AP, t_RP, fs)
% Assignment 4 : Exercise 3.4
%   RMS level estimation 
%
%   sig - linear input levels
%   lastP - last calculated value of peak
%   t_AP - attack time (ms)
%   t_RP - release time (ms)
%   fs - sampling frequency

    % set default sampling frequency
    if nargin<5, fs=44100; end
    
    %attack, AP
    aux_AP = -2197/(t_AP*fs);
    AP = 1-exp(aux_AP);
    %release, RP
    aux_RP = -2197/(t_RP*fs);
    RP = 1-exp(aux_RP);

    % initializations
    xpeak = 0;
    p = [];
    
    %sample-wise peak level estimation
    for n = 1:length(sig)
        % current sample
        sample = sig(n);
        %__________computation of Peak level detection block diagram__________
        abs_sample = abs(sample);
        aux1 = abs_sample-lastP;
        
        % negative values => 0
        if aux1 < 0
            aux2 = 0;
        % positive values => stay the same
        else
            aux2 = aux1;
        end
        aux3 = aux2*AP;
        aux4 = aux3+lastP;
        
        %decision block for peak level
        if abs_sample > xpeak
            dec = 0;
        else
            dec = RP*lastP;
        end
        xpeak = aux4 - dec;
        
        %update last peak for next sample computation
        lastP = xpeak;
        %output
        p(n) = xpeak;
        %_______________________________________________________________
    end
end