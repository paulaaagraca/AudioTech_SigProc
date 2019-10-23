%
% Author : Paula A A Graça
% Student @ TUM 2019
%
function M = comp_delay(N, t60, fs)
% Assignment 6 : Exercise 1.2
%   Calculate delay lengths
%
%   N - number of channels
%   t60 - maximum reverberation time
%   fs - sampling frequency

    
    % set default sampling frequency
    if nargin<3, fs=44100; end 
    
    % default - prime numbers below 100
    prime_array = primes(100);
    % take the N first prime numbers
    prime_nums = prime_array(1:N);
    
    % minimum delay line lengths
    min_sum_M = 0.15 * t60 * fs;
    % average delay line length
    M_avg = 1/N * (min_sum_M);
    % multiplicities of primes
    m = round(log10(M_avg)./log10(prime_nums)); 
    
    % calculate delay lengths
    M = prime_nums.^m;
       
end
