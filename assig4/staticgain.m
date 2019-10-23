%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function gain=staticgain(level, cr, lim_thr, comp_thr, gate_thr)
% Assignment 4 : Exercise 3.2
%   Static gain (linear) for dynamic range compressor
%
%   level - linear input levels
%   cr - compression ration
%   lim_thr - limiting threshold
%   comp_thr - compression threshold
%   gate_thr - gate threshold

    % absolute values of input
    abs_level = abs(level);

    %initialize auxiliar vector
    aux_out = [];
    % slope between lim_thr and comp_thr
    slope = 1/cr;
    % value of y=slope*x + b
    b = - slope * comp_thr + comp_thr;
    
    % sample-wise conversion of level to gain(dB)
    for n = 1:length(abs_level)
        % current sample
        sample = abs_level(n);
        
        % gating range
        if sample < gate_thr
            gain(n) = 0;
        
        % linear range
        elseif (sample > gate_thr) && (sample < comp_thr)
            gain(n) = 1;
            
        % above linear range
        elseif (sample >= comp_thr)
             % linear function between lim_thr and comp_thr
            compr = slope*sample + b; 
            % gain in dB
            db_gain = compr-sample;
            
            % in compressing range
            if compr < lim_thr
                gain(n) = 10^(db_gain/20);
            % in liminting range
            else 
                gain(n) = 10^((lim_thr-sample)/20);
            end
        end
    end
end 
