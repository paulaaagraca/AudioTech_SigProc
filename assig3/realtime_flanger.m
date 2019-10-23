%
% Author : Paula A A Graça
% Student @ TUM 2019
%
classdef realtime_flanger < audioPlugin
% Assignment 3 - Exercise 2 :
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
        function proc_buf = process(plugin,input,param)
            aux_to_buf=[];                            
            % if is reading the first x buffers then do not process
            if (plugin.state.count < plugin.state.val*plugin.state.initdata.pagesize)
                % one entire buffer size
                plugin.state.count = plugin.state.count + plugin.state.initdata.pagesize; 
                % concatenate previous prev_buff with new input
                if(plugin.state.val > 1)
                    plugin.state.prev_buff = [plugin.state.prev_buff(end-plugin.state.initdata.pagesize*(plugin.state.val-1)+1:end,1:plugin.state.initdata.numinchan);input];
                % if prev_buff size is 1 buffer
                else    
                    plugin.state.prev_buff = input ;
                end
                proc_buf = zeros(plugin.state.initdata.pagesize,plugin.state.initdata.numinchan); 
            %if is reading after the 2 buffers then process              
            else  
    
                signal = [plugin.state.prev_buff; input];
                del = plugin.state.M0*(1+param(1)*sin(2*pi*param(2)*(1:size(input,1))/plugin.state.fs)); 
                %del = del';
                m=size(plugin.state.prev_buff,1)+1:size(signal,1);
                aux = interp1(signal,m-del,'linear');
                
                
%                 signal = [plugin.state.prev_buff; input];
%                 del = plugin.state.M0*(1+param(1).*sin((2*pi*param(2).*(1:size(signal,1)))/plugin.state.fs)); 
%                 del = del';
%                 aux = interp1(signal,(size(plugin.state.prev_buff))+1:(size(signal,1)),'linear');
%                 
%                 
%                for n = 1:length(input) %can be n=(1:length(input))
%                     del = plugin.state.M0*(1+param(1).*sin(2*pi*param(2).*n/plugin.state.fs)); 
%                     if (n - del) > 0
%                         %calculate which sample is to be used
%                         n_sample = n-del;
%                         aux = interp1(input,n_sample,'linear');
%                         aux_to_buf = [aux_to_buf;aux];  %consider pre allocating
%                     else 
%                         n_sample = length(plugin.state.prev_buff)+n-del;
%                         aux = interp1(plugin.state.prev_buff,n_sample,'linear');
%                         aux_to_buf = [aux_to_buf;aux];
%                     end
%                 end

                proc_buf = aux*plugin.state.g + input*(1-plugin.state.g);
            end 
            plugin.output = proc_buf;
        end
        
        % initialization routine
        function initialize(plugin,initdata)
            % maximum delay in samples = 2*M0
            M0 = 441;
            M_max = 2*M0;
            % check how many buffers are needed 
            val = ceil(M_max/initdata.pagesize);
            % check how many samples are needed in total in all buffers
            val_samples = val*initdata.pagesize;
            % variables to be passed from page-to-page
            plugin.state = struct('initdata', initdata, 'M0', M0,'prev_buff', zeros(val_samples,initdata.numinchan),'fs', initdata.fs, 'count', 0, 'val', val, 'g', 0.5);
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
            output = {'a', 'f'};
        end
        % get parameter range
        function output = getparamranges(plugin)
            % return a cell array with parameter ranges
            % Set the min and max values of the slider bar of each parameter
            % Should have same number of elements as 'getparamnames'
            output = {[0,1], [0,25]};
        end
     end
end
