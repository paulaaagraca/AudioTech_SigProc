%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function out=sin_fade(sig, t_fadein, t_fadeout, fs)
% Assignment 4 : Exercise 1.2
%   Modulation with an envelope
%
%   sig - input
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
        fadein_scale = linspace(edge_gain,1,fadein_samples);
        sinefade_in = ((1-cos(pi*fadein_scale))/2)';

        % compute fade in
        sig_faded(1:fadein_samples,1)= sig(1:fadein_samples,1).*sinefade_in;

        % create fade out
        fadeout_scale = linspace(edge_gain,1,fadeout_samples);
        sinefade_out = ((1-cos(pi*fadeout_scale))/2)';
        % compute fade out
        sig_faded(end - fadeout_samples+1:end,1) = sig(end-fadeout_samples+1:end,1).*sinefade_out(end:-1:1); 

        %assign output value -> faded signal
        out = sig_faded;
    end
end
