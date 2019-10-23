%
% Author : Paula A A Graça
% Student @ TUM 2019
%

aPR = init_aPR;
fs = 44100;

time = 2;
sample_len = time*fs;
n_buff = sample_len/aPR.BufferSize;

%aPR.BufferSize = 2048;
buf_sz = aPR.BufferSize;
playbuf = zeros(aPR.BufferSize*10,2);
playbuf(300,1) = 1;
playbuf(300,2) = 1;
figure 
plot(playbuf)

for i = 1:buf_sz:sample_len %1:87*5
    
    [recbuf] = aPR(playbuf(i:i+buf_sz,:)) 
    rectot = [rectot; recbuf];

end

figure
plot(rectot)
