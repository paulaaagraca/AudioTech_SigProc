function [matrix] = mixing_matrix(N)
% Assignment 6 : Exercise 1.1
%   Creation of mixing matrix
%
%   N - matrix NxN (is a power of 2)
%
    
    %---------check if N is power of 2------------
    n = N;
    while n > 1
        if(mod(n,2) ~= 0)
            error('N has to be a power of 2!');
        else
            n = n / 2;
        end
    end
    %---------------------------------------------
    
    % calculate Hadamard matrix
    had_mat = hadamard(N);
    % calculate norm of matrix
    norm_mat = norm (had_mat);
    % devide matrix by norm -> ensure ||A||=1
    matrix = had_mat ./ norm_mat;

end