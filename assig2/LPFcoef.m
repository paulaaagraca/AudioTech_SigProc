%
% Author : Paula A A Graça
% Student @ TUM 2019
%

function [B,A]=LPFcoef(cutoff,angle,fs)
%Assignment 2 - Exercise 3.1 : 
%   IIR Filter Design
%   -> Function calculates coefficients of a digital second order lowpass
%   filter with given cutoff frequency, resonant angle and sample frequency
%
%   Inputs:
%   cutoff = cutoff frequency desired for the LP filter (in Hz)
%   angle = parameter that controls the resonant behaviour; S-plane (in degrees)
%   fs = samling frequency (44100Hz)
%   
%   Outpus:
%   A = coefficient vector of polynomial with roots at zp and zp_conj
%   B = coefficient vector of polynomial with roots at -1 
%

% conversion from degrees to radians 
angle = deg2rad(angle);
% conversion from Hz to radians
w_cutoff = cutoff*2*pi/fs;

% Equation 5
omega_c = tan(w_cutoff/2);       

% cosine of angle = (Real part of pole) / (-cutoff frequency)
% ('-cutoff' to keep pole in left side of the plane) 
calc_real = cos(angle)*(-omega_c);
% sine of angle = (Imaginary part of pole) / (-cutoff frequency)
% ('-cutoff' to keep pole in left side of the plane) 
calc_imag = sin(angle)*(-omega_c); 


% calculate poles
sp = calc_real + i*calc_imag;
% Equation 3
zp = (1+sp)/(1-sp);         
zp_conj = conj(zp);

% coefficient vector of polynomial with roots zp and zp_conj 
A = poly([zp zp_conj]);


% Filter H(z) = g*(1+z)*(1+z)/((z-zp)*(z-zp_conj));
% DC -> w=0; s=0; z=1
z=1;
g = ((z-zp)*(z-zp_conj))/((1+z)*(1+z));

% coefficient vector of polynomial with roots -1; DC gain equal to 1 
B = g*poly([-1 -1]);

end


% Assignment 2 - Exercise 3.2 
%
%   Second order filters have resonance, so the cutoff frequency is
%   not -3dB as in first order filters.
%   In this case,the resonance coefficient is regulated by the 'angle' parameter.
%   The angle of resonance is translated as the angle between the poles and
%   the real axis, and because the poles are complex conjugates, negative angles
%   are redundant and produce results mirrored from positive angles (in zplane).
%   So, when the angle reaches the minimum value of 0 (no resonance), the gain 
%   at cutoff frequency is -6dB and cannot be lower with any other angle
%   value.
