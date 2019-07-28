function out=filter_FDN(u,d,N,t60DC,t60Nyq,fs)
% Assignment 6 : Exercise 1.5
%
%   u - input signal
%   d - direct path gain
%   N - number of channels
%   t60DC - reverberation time
%   t60Nyq - reverberation time
%   fs - sampling frequency

    % set default sampling frequency
    if nargin<6, fs=44100; end 
    
    % b, c, g coefficients
    b = ones(N,1);
    c = ones(N,1);
    g = ones(N,1);
    
    % pre-allocation
    x = zeros(N, length(u));
    x_del = zeros(N,1);
    B = zeros(N,1);
    C = zeros(N,1);
    alpha_filtered = zeros(N,1);
    beta_filtered = zeros(N,1);
    
    out = zeros(length(u),1);
    
    % mixing matrix calculation
    A = mixing_matrix(N);
    % channels delays (column)
    M = comp_delay(N, t60DC, fs)';
    
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
            
            %_______ G filter ___________________________________
            
            aux1 = -3*M(channel,1);
            aux2 = t60DC*fs;
            aux3 = t60Nyq*fs;
            % calculate G filter for DC
            G_DC = 10^(aux1/aux2);
            % calculate G filter for Nyquist
            G_Nyq = 10^(aux1/aux3);
            
            %calculate alpha/beta of i channel
            alpha = (G_DC + G_Nyq)/2;
            beta = G_DC - alpha;
            
            % alpha * delayed x
            alpha_filtered(channel,1) = alpha * x_del(channel,1);
            
            % beta * delayed x - 1 sample
            if n==1
                beta_filtered(channel,1) = beta * x(channel, n);
            else
                beta_filtered(channel,1) = beta * x(channel, n-1);
            end
            %_____________________________________________________
            
            % final delayed block
            B(channel, 1) = alpha_filtered(channel,1) + beta_filtered(channel,1);
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

% The sound still shows some roughness in some of the tones. One way to
% make the sound more natural would be to apply a dynamic range control and 
% remove some of the distortion.