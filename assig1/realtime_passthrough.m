function [recdata]= realtime_passthrough(time)
% reads audio data from the microphone for a duration of time (in seconds), 
% outputs it (without processing) to the headphones in real time 
% (i.e. implement the initialization and real-time loop explained above) 
% and returns all the audio data fetched as a vector recdata

aPR = init_aPR;
buffersize = aPR.BufferSize;
fs = aPR.SampleRate;

num_buff = ceil((time*fs)/buffersize);
recdata = zeros(buffersize*num_buff,2);
rectot=[];

for c = 1:num_buff
    
    [recdata] = aPR(zeros(aPR.BufferSize,2)); 
    rectot = [rectot; recdata];
    
end
    recdata = rectot;
end