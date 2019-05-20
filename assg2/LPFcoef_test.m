fs=44100;
cutoff = 100; 
angle = 45;

[B,A] = LPFcoef(cutoff,angle,fs)
