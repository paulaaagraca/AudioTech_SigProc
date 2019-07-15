% Assignment 2 - Exercise 1 : 
%   Windowing method for FIR filter design
%
%   h - sinc function
%   wh - hamming window
%   wg - gaussian window
%   wk - kaiser window
%   fs - sampling frequency
%   fN - Nyquist frequency
%
%   freqz.m - used to plot the frequency response of the filter
%

fs= 44100;
fN=fs/2; 

%plot the three kinds of windows for n=15 and n=127
for n=15:112:127

    %sinc function with length 2n+1
    h =(sinc((-n:n)/4.41)/4.41)';
    %compute 3 different windows: hamming, gaussian, kaiser
    wh = hamming(2*n+1); 
    wg = gausswin(2*n+1,2.5);
    wk = kaiser(2*n+1,2.5);

    % f = wn*fs/2pi
    % frequency responses and phases
    figure
    freqz(h.*wh)    % plot hamming
    figure
    freqz(h.*wg)    % plot gaussian
    figure
    freqz(h.*wk)    % plot kaiser
end

%__________________OBSERVATIONS_______________________
% 
%   - At -3dB, the 'cutting-off frequency' for all windows is a little 
%   below the 5KHz defined frequency, being more aproximate for the kaiser
%   window;
%
%   - The hamming and gaussian windows does not present any ripple, while the
%   kaiser window present a 0.15 minimal 'passband-ripple';
%
%   - The 'stopband-ripple' for the kaiser window is significantly higher
%   than the other two windows (difference > 20dB), indicating that its first 
%   lobe has higher energy for stopband frequencies, while the the gaussian 
%   has the lowest stopband-ripple; 
%
%   - The 'transition bandwith' has the stiffest slope for the kaiser
%   window, which indicates that it has the fastest transition. The slowest
%   transition (gentlest slope) is verified in the gaussian window.
%   
%   - All graphs present linear 'phase' in the passband and transition areas,
%   hamming phase presents the less variation torwards higher frequencies
%   and kaiser has the most variable phase.
%
%   - If the window length is increased, the system gets less stable as the 
%   number of ripples in the stopband area increases as well.
%
%   .: Overall, the Hamming window presents the less energetic ripples for
%   the stopband; the Kaiser window presents the fastest transition