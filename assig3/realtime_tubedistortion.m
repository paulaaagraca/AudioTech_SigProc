classdef realtime_tubedistortion < audioPlugin
% Assignment 3 - Exercise 3.3 :
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
 
            % calculate pre-gain
            in_pregain = input.*10^(param(1)/20) + param(3);
            % distortion effect
            g = sign(in_pregain).*(1-exp(-4*abs(in_pregain)));
            
            % flow diagram for distortion 
            proc_buf = g.*param(2) + input*(1-param(2));
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
            output = {'pre-gain', 'dry/wet', 'c'};
        end
        % get parameter range
        function output = getparamranges(plugin)
            % return a cell array with parameter ranges
            % Set the min and max values of the slider bar of each parameter
            % Should have same number of elements as 'getparamnames'
            output = {[-25,35], [0,1], [0,0.5]};
        end
    end
end