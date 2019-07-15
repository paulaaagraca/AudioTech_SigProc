function dBout=staticcurve(dBin, cr, lim_thr, comp_thr, gate_thr)
% Assignment 4 : Exercise 3.1
%   Static curve (dB) for dynamic range compressor
%
%   dBin - input levels (dB)
%   cr - compression ration
%   lim_thr - limiting threshold
%   comp_thr - compression threshold
%   gate_thr - gate threshold

    %initialize auxiliar vector
    aux_out = [];
    % slope between lim_thr and comp_thr
    slope = 1/cr;
    % value of y=slope*x + b 
    b = - slope * comp_thr + comp_thr;
    
    % sample-wise conversion of dBin to dBout
    for n = 1:length(dBin)
        % current sample
        sample = dBin(n);
        
        % gating range
        if sample < gate_thr
            aux_out = [aux_out; -100]; % 0 or -100 ? 
        
        % linear range
        elseif (sample > gate_thr) && (sample < comp_thr)
            aux_out = [aux_out; sample];
        
        % above linear range
        elseif (sample >= comp_thr)
            % linear function between lim_thr and comp_thr
            compr = slope*sample + b; 
            % in compressing range
            if compr < lim_thr
                aux_out = [aux_out; compr];
            % in liminting range
            else 
                aux_out = [aux_out; lim_thr];
            end
        end
    end
    
    % output
    dBout = aux_out;
end 