[sig,Fs] = audioread('AIP_Song.wav');
%sound(sig,Fs)

speed = 10;
out=lin_resample(sig,speed);
%sound(out,Fs/speed)
figure
plot(out) 
