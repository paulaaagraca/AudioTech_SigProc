function out = lossless_FDN(u,d,N,t60,fs)
% Assignment 6 : Exercise 1.3
%
%   u - input signal
%   d - direct path gain
%   N - number of channels
%   t60 - maximum reverberation time
%   fs - sampling frequency

    % set default sampling frequency
    if nargin<5, fs=44100; end 
    
    % b, c, g coefficients
    b = ones(N,1);
    c = ones(N,1);
    g = ones(N,1);
    
    % pre-allocation
    x = zeros(N, length(u));
    x_del = zeros(N,1);
    B = zeros(N,1);
    C = zeros(N,1);
    out = zeros(length(u),1);
    
    % mixing matrix calculation
    A = mixing_matrix(N);
    % channels delays (column)
    M = comp_delay(N, t60, fs)';
    
    % bit-wise SISO FDN
    for n = 1:length(u)
    % __________________________________________________________________
        % channel-wise intermedium calculations
        for channel = 1:N
            % delay is outside the input vector
            if n <= M(channel,1)         % row,column
            	x_del(channel,1) = 0;    % row,column 
            % delay is a previous computed x
            else 
                del_index = n - M(channel,1);
                x_del(channel,1) = x(channel, del_index);
            end
            % gi * xi(n-Mi)
            B(channel, 1) = g(channel,1) * x_del(channel,1);
            % bi * u(n)
            C(channel, 1) = b(channel,1) * u(n);
        end
   % __________________________________________________________________
        
        % compute x for N channels (Equation 1)
        x(:,n) = A * B + C;
        
        % y output (Equation 2)
        D = c' * B;
        out(n) = d*u(n) + D;
    end
end