function GraphLayout = GraphLayoutInitialize(Graph, varargin)
% Initialized graph layout - a structure containing instructions for plotting the graph
%
% Receives:
%   Graph - structure - the graph, see GraphLoad    
%   NodeProperties  -  struct / cell of structs - defines the properties of 
%   EdgeProperties  
%   varargin        -   FLEX IO -   The input is in FlexIO format.  The following parameters are allowed:
%                                       Parameter Name          |  Type         |  Optional |   Default Value |   Description
%                                           
%
%
%
%
%
% See Also:
%   GraphLoad, GraphLayoutAddFrame, GraphLayoutDraw
%
%

%% test input  + defaults
error(nargchk(1,inf,nargin));
error(nargoutchk(0,1,nargout));

if ~FIOProcessInputParameters(GetDefaultInput)
    error('The default input is not FlexIO compatible');
end
if ~FIOProcessInputParameters(varargin)
    error('The input is not FlexIO compatible');
end

%% initialize
GraphLayout = [];
GraphLayout.Graph = Graph; 
GraphLayout.Type = 'Graph Layout';
GraphLayout.Frames = {}; 
GraphLayout.Export = [];
GraphLayout.DrawSettings = [];
GraphLayout.Parameters = [];
GraphLayout.Parameters.CodeFolder =[ fileparts(mfilename('fullpath')) '/'];
GraphLayout.Parameters.CodeFolder(GraphLayout.Parameters.CodeFolder=='\') = '/';
GraphLayout.Parameters.TempFolder = [GraphLayout.Parameters.CodeFolder 'TempStorage/'];
GraphLayout.Parameters.JARFileName = [ GraphLayout.Parameters.CodeFolder 'javaGraphDraw.jar'];
if ~exist(GraphLayout.Parameters.TempFolder ,'dir')
    try 
        mkdir(GraphLayout.Parameters.TempFolder); 
    catch er
           warning('Can''t create folder ''%s'' er: %s',GraphLayout.Parameters.TempFolder,er);
    end
end
if ~exist(GraphLayout.Parameters.TempFolder ,'dir'),error('Filed to create necessary folder ''%s''', GraphLayout.Parameters.TempFolder); end


end % InitializeGraphLayout


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DefaultInput  = GetDefaultInput()
DefaultInput = {};

% DefaultInput    =   FIOAddParameter(DefaultInput,'NumberOfBins',15);
% DefaultInput    =   FIOAddParameter(DefaultInput,'GraphFigureHandle',[]);
% DefaultInput    =   FIOAddParameter(DefaultInput,'ShowMenuBar',false);
% DefaultInput    =   FIOAddParameter(DefaultInput,'NodesOnTop',true);
% DefaultInput    =   FIOAddParameter(DefaultInput,'NodeProperties',{});
% DefaultInput    =   FIOAddParameter(DefaultInput,'EdgeProperties',{});

end % GetDefaultInput()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
