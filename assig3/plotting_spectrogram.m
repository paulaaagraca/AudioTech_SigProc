% Assignment 3 - Exercise 3.4:
%   Spectral Analysis
%
%   The spectograms shoud all show a stronger frequency line in 4kHz.
%   For normal distortion, only dd harmonics are created at 4kHz, 12kHz,
%   20kHz, and so on (8k of interval).
%   When applying the tube distortion, the same harmonic appear, adding
%   up the even harmonics as well, at 8kHz, 16kHz, 24kHz, and so on (8k of
%   interval).
%   Because the overdrive effect is more flat than distortion around the
%   extremities, then it uses more harmonics to achieve that effect. 

fs = 44100; 
tsample = 5;
tfade = 4;
% calculate number of samples for 5sec
n_samples = tsample*fs;
% create sinusoi signal - f= 4KHz; 5sec
sig_samples = linspace(0,1,n_samples);
sig = (sin(2*pi*4000*sig_samples))';

% calculete number of samples for fade
fade_samples = tfade*fs;
% create exponential fade of -20dB
fade_scale = linspace(0,1,fade_samples);
e = exp(log(0.1)*(fade_scale));

% apply exponential fade to sig
sig_faded = sig;
sig_faded(end - fade_samples+1:end) = sig(end-fade_samples+1:end).*e'; 

% use created signal as input of distortion, overdrive and tube-distortion
dist = realtime_sample_processing(aPR,sig_faded,realtime_distortion,[],[5 0.5],[1 2]);
over = realtime_sample_processing(aPR,sig_faded,realtime_overdrive,[],[5 0.5],[1 2]);
tube = realtime_sample_processing(aPR,sig_faded,realtime_tubedistortion,[],[5 0.5 0.1],[1 2]);

% create Hann window of length = 256
w = hann(256);
% calculate stft for each signal with effect + original signal
[X_s,freqs_s,times_s]=stft(sig_faded, w);
[X_d,freqs_d,times_d]=stft(dist(:,1), w);
[X_o,freqs_o,times_o]=stft(over(:,1), w);
[X_t,freqs_t,times_t]=stft(tube(:,1), w);

% ______________ plot frequency-time spectrograms ______________
figure
%original
subplot(1,4,1)
imagesc(times_s,freqs_s/1000,abs(X_s));set(gca,'YDir','normal');
title('Original');
xlabel('Time (s)') 
ylabel('Frequency (Hz)'); 

%distortion
subplot(1,4,2)
imagesc(times_d,freqs_d/1000,abs(X_d));set(gca,'YDir','normal');
title('Distortion');
xlabel('Time (s)') 
ylabel('Frequency (Hz)'); 

%overdrive
subplot(1,4,3)
imagesc(times_o,freqs_o/1000,abs(X_o));set(gca,'YDir','normal');
title('Overdrive');
xlabel('Time (s)') 
ylabel('Frequency (Hz)'); 

%tube-distortion
subplot(1,4,4)
imagesc(times_t,freqs_t/1000,abs(X_t));set(gca,'YDir','normal');
title('Tube Distortion');
xlabel('Time (s)') 
ylabel('Frequency (Hz)'); 

% % ______________ plot amplitude-time graphs ______________
% 
% %original
% subplot(2,4,5)
% plot(sig_faded);
% title('Original');
% xlabel('Time (s)') 
% ylabel('Amplitude'); 
% 
% %distortion
% subplot(2,4,6)
% plot(dist(:,1));
% title('Distortion');
% xlabel('Time (s)') 
% ylabel('Amplitude'); 
% 
% %overdrive
% subplot(2,4,7)
% plot(over(:,1));
% title('Overdrive');
% xlabel('Time (s)') 
% ylabel('Amplitude'); 
% 
% %tube-distortion
% subplot(2,4,8)
% plot(tube(:,1));
% title('Tube Distortion');
% xlabel('Time (s)') 
% ylabel('Amplitude'); 
