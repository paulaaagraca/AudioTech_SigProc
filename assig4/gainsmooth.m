function gs=gainsmooth(gain, lastGS, t_AS, t_RS, fs)
% Assignment 4 : Exercise 3.4
%   Gain smoothing for dynamic range compressor
%
%   gain - gain signal
%   lastGS - last calculated value of gain smoothing
%   t_AS - attack time (ms)
%   t_RS - release time (ms)
%   fs - sampling frequency

    % set default sampling frequency
    if nargin<5, fs=44100; end

    %attack, AS
    aux_AS = -2197/(t_AS*fs);
    AS = 1-exp(aux_AS);
    %release, RS
    aux_RS = -2197/(t_RS*fs);
    RS = 1-exp(aux_RS);
    
    % output vector initialization
    gs = zeros(size(gain));
    
    for n = 1:length(gain)
        %current output
        sample = gain(n);
        %__________computation of gain smoothing block diagram__________
        if sample > lastGS
          gs(n) = (1-RS)*lastGS + RS*sample;    
        else
          gs(n) = (1-AS)*lastGS + AS*sample;
        end
        lastGS = gs(n);
        %_______________________________________________________________
    end
end