function [recdata,play] = realtime_gain(time,db_gain)
% takes an additional parameter db_gain specifying a gain in decibels
% and applies that gain to recorded signal before real-time playback
% Return both the recorded and played-back data. 
%

aPR = init_aPR;
buffersize = aPR.BufferSize;
fs = aPR.SampleRate;

num_buff = ceil((time*fs)/buffersize);
recdata = zeros(buffersize*num_buff,2);
rectot=[];
play = zeros(aPR.BufferSize,2);

for c = 1:num_buff
    
    [recdata] = db_gain*aPR(play);
    rectot = [rectot; recdata];
end
    recdata = rectot;
end