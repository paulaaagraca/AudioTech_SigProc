%
% Author : Paula A A Graça
% Student @ TUM 2019
%
classdef realtime_overdrive < audioPlugin
% Assignment 3 - Exercise 3.2 :
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

            % assignments from sliders
            pregain = param(1);
            drywet = param(2);
            
            %initialize nonlinear characteristic vector
            f_total = [];
            % calculate pre-gain
            in_pregain = input.*10^(param(1)/20);
            abs_in_pregain = abs(in_pregain);
            
            % distortion effect for each sample
            for n = 1:length(input)
                
                % non linear overdrive effect conditions
                if (0 <= abs_in_pregain(n)) && (abs_in_pregain(n) <= (1/3))
                    f(n,1) = 2*in_pregain(n);
                elseif (1/3 <= abs_in_pregain(n)) && (abs_in_pregain(n) <= (2/3))
                    f(n,1) = sign(in_pregain(n)).*(3-(2-3*abs_in_pregain(n)))^2/3; 
                elseif (2/3 <= abs_in_pregain(n))
                    f(n,1) = sign(in_pregain(n));
                end
            end
            
            % flow diagram for distortion
            proc_buf = f*drywet + input*(1-drywet);
            % make output availabe outside the plugin
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
            output = {'pre-gain', 'dry/wet'};
        end
        % get parameter range
        function output = getparamranges(plugin)
            % return a cell array with parameter ranges
            % Set the min and max values of the slider bar of each parameter
            % Should have same number of elements as 'getparamnames'
            output = {[-25,35], [0,1]};
        end
    end
end
