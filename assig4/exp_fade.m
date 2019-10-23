%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function out=exp_fade(sig, minimum_dB, t_fadein, t_fadeout, fs)
% Assignment 4 : Exercise 1.3
%   Modulation with an envelope
%
%   sig - input
%   minimum_dB - minimum gain of fade (dB)
%   t_fadein - fade-in duration (ms)
%   t_fadeout - fade-out duration (ms)
%   fs - sampling frequency

    % calculate number of samples for fade in
    fadein_samples = t_fadein*0.001*fs;
    % calculate number of samples for fade out
    fadeout_samples = t_fadeout*0.001*fs;
        
    % verify if fade in and fade out overlap
    if(fadein_samples + fadeout_samples > length(sig))
        disp('WARNING : Fade in and fade out are too long. Reduce time!');
        %random output because of error
        out = zeros(1);
    else
        %tranfer original sig to the future faded output
        sig_faded = sig;
        
        %calculate gain for first and last sample
        edge_gain = 1/(2*fs);
        
        % create fade in
        fadein_scale = logspace(minimum_dB,0,fadein_samples);

        % compute fade in
        sig_faded(1:fadein_samples,1)= sig(1:fadein_samples,1).*fadein_scale';

        % create fade out
        fadeout_scale = logspace(minimum_dB,0,fadeout_samples);
        % compute fade out
        sig_faded(end - fadeout_samples+1:end,1) = sig(end-fadeout_samples+1:end,1).*fadeout_scale(end:-1:1)'; 

        %assign output value -> faded signal
        out = sig_faded;
    end

end
