aPR = init_aPR;

[recbuffer] = aPR(zeros(aPR.BufferSize,2)); 
recvector = [];

for c = 1:87
    %recording
    [recbuffer] = aPR(zeros(aPR.BufferSize,2)); 
    recvector = [recvector; recbuffer];
    
end
%plot recorded vector
plot(recvector) 
%play recorded vector
[~]= aPR([recvector recvector]) 

%bit depth = 16 bits