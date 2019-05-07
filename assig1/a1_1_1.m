aPR = init_aPR;
n=512;
fs = 44100;
time = 1; % sec
low_lim = -1;
high_lim = 1;
signal = (high_lim - low_lim).*rand(time*fs,2)-high_lim;
[~] = aPR(signal);

[recbuffer] = aPR(zeros(aPR.BufferSize,2));
recvector = [];


for c = 1:87
    
    [recbuffer] = aPR(zeros(aPR.BufferSize,2));
    recvector = [recvector; recbuffer];
    
end
l = unique(recvector);