%
% Author : Paula A A Graça
% Student @ TUM 2019
%
% 2.1
aPR = init_aPR;
recdata = realtime_passthrough(4)
plot(recdata)

% 2.2 - Latency is 2*buffersize because there is 1 page to record and 1 page to 
% process the data, and only then the sound can be played
