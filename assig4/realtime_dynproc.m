%
% Author : Paula A A Graça
% Student @ TUM 2019
%
classdef realtime_dynproc < audioPlugin
% Assignment 4 - Exercise 3.6 :
%   Real time implementation of a dynamic processor
%
    properties
        % initialize state structure
        state = struct();
        % initialize output
        output = [];
    end
    properties (Access = private)
        % insert your private parameters here. These parameters are not
        % visible for the user.
        % No changes needed
    end
    methods
        % processing algorithm
        function proc_buf = process(plugin, input, param)
            
            fs = 44100;
            
            % identification of param's
            cr = param(1);
            lim_thr = param(2);
            comp_thr = param(3);
            gate_thr = param(4);
            t_AP = param(5);
            t_RP = param(6);
            t_AS = param(7);
            t_RS = param(8);
            t_delay = param(9);
            outgain = param(10);
           
            %number of delay samples
            D = t_delay*0.001*fs;
            
            %calculate delay vector for D samples
            for n = 1:length(input)
                if n > D
                    del(n) = input(n-D);
                else
                    del(n) = 0;
                end 
            end
            
            % peak level estimation 
            level_estimated = peaklevel(input, 0, t_AP, t_RP)';
            % apply static curve for linear gain
            static_gain = staticgain(level_estimated, cr, lim_thr, comp_thr, gate_thr)';
            % gain smoothing
            g = gainsmooth(static_gain, 0, t_AS, t_RS);
           
            %apply delay vector to processed signal g
            out = del'.*g;
            %apply output_gain
            proc_buf = out * 10^(outgain/20);
            %update output
            plugin.output = proc_buf;
        end
        
        % initialization routine
        function initialize(plugin,initdata)
            % generate a default state and return it
            % e.g. plugin.state.BufferSize = initdata.pagesize;
            plugin.state = struct();
        end
        % get number of input channels
        function output = getnuminchan(plugin)
            % return number of input channels
            % No changes needed
            output = -1; % arbitrary number of input channels
        end
        % get number of output channels
        function output = getnumoutchan(plugin,input)
            % return number of input channels
            % No changes needed
            % input here number of channels
            output = -1; % arbitrary number of input channels
        end
        % get parameter names
        function output = getparamnames(plugin)
            % return a cell array with parameter names
            % Provides labels for the slider bars controlling each parameter -
            % One slider bar for each parameter
            % Should have same number of elements as 'getparamranges'
            output = {'cr', 'lim_thr','comp_thr', 'gate_thr', 't_AP', 't_RP', 't_AS', 't_RS', 't_delay', 'outgain'};
        end
        % get parameter range
        function output = getparamranges(plugin)
            % return a cell array with parameter ranges
            % Set the min and max values of the slider bar of each parameter
            % Should have same number of elements as 'getparamnames'
            output = {[1,10], [-100,0], [-100,0], [-100,0], [0,25], [0,500], [0,25], [0,500], [0,500],  [0,40]};
        end
    end
end
