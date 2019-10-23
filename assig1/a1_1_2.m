%
% Author : Paula A A Graça
% Student @ TUM 2019
%

aPR = init_aPR;

[recbuffer] = aPR(zeros(aPR.BufferSize,2)); 
recvector = [];

for c = 1:87
    %recording
    [recbuffer] = aPR(zeros(aPR.BufferSize,2)); 
    recvector = [recvector; recbuffer];
    
end

%bit depth = 16 bits
