%
% Author : Paula A A Graça
% Student @ TUM 2019
%
classdef sqrtcomp < audioPlugin
% Assignment 4 : Exercise 2.1
%   Instantaneous compression
%   
%   Audio plugin for real time compression
%
%   The distortion heard is due to the non linearity of the square root
%   equation that creates phase distortion since its state is not saved
%   from page to page.

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

            % sample-wise square-root compression
            abs_in = abs(input);
            y = sign(input).*sqrt(abs_in);
            
            % output
            proc_buf = y;
            plugin.output = proc_buf;
            
        end
        
        % initialization routine
        function initialize(plugin,initdata)
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
            output = {};
        end
        % get parameter range
        function output = getparamranges(plugin)
            % return a cell array with parameter ranges
            % Set the min and max values of the slider bar of each parameter
            % Should have same number of elements as 'getparamnames'
            output = {};
        end
    end
end
