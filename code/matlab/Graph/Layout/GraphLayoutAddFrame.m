function GraphLayout = GraphLayoutAddFrame(GraphLayout, varargin)
%adds (time) frame to graph layout. any graph layout must have at least one frame (static graph).
% Note that every following frame should only specify the properties that should be changed from the earlier frame. 
%
% Receives:
%   GraphLayout - structure - see GraphLayoutInitialize 
%   
%   varargin        -   FLEX IO -   The input is in FlexIO format.  The following parameters are allowed:
%                                       Parameter Name          |  Type         |  Optional |   Default Value |   Description
%                                           Algorithm           | structure     |  yes      |  Algorithm = CreateAlgorithmProperties('Algorithm','None','LayoutTimeOut',0,'LabelAdjustTimeOut',0); | definition of the alogorithm to apply, generated with CreateAlgorithmProperties. 
%                                           Preview             | structure     | yes       | Preview = CreatePreviewProperties({'SHOW_NODE_LABELS','EDGE_CURVED','NODE_LABEL_PROPORTIONAL_SIZE'}, {true, false,false}  ); | 
%                                           NodesAdd            |  vector       | yes       |     []          | list of nodes to add to the graph
%                                           NodesRemove         |  vector       | yes       |     []          | list of nodes to remove from the graph
%                                           EdgesAdd            |  vector, m*2  | yes       |     []          | list of edges to remove from the graph
%                                           EdgesRemove         |  vector, m*2  | yes       |     []          | list of edges to remove from the graph
%                                           NodeProperties      |struct/cell of structs | yes | see GetDefaultInput() | defines the properties of the set of nodes. If different node properties are used, group structs in cell array. see CreateNodeProperties
%                                           EdgeProperties      |struct/cell of structs | yes | see GetDefaultInput() | defines the properties of the set of nodes. If different node properties are used, group structs in cell array. see CreateEdgeProperties
%                                           
%
%
%
%
% See Also:
%   GraphLayoutInitialize,GraphLayoutDraw,  CreateNodeProperties, CreateEdgeProperties, CreateAlgorithmProperties

%% test input  + defaults
narginchk(2,inf);
nargoutchk(0,1);

if ~FIOProcessInputParameters(GetDefaultInput)
    error('The default input is not FlexIO compatible');
end
if ~FIOProcessInputParameters(varargin)
    error('The input is not FlexIO compatible');
end

if isstruct(NodeProperties), NodeProperties = {NodeProperties}; end
if isstruct(EdgeProperties), EdgeProperties = {EdgeProperties}; end

Frame = [];
Frame.Index= numel(GraphLayout.Frames)+1;
Frame.Algorithm = Algorithm;
Frame.Preview = Preview;
Frame.NodeProperties = NodeProperties;
Frame.EdgeProperties = EdgeProperties;
Frame.NodesAdd = NodesAdd;
Frame.NodesRemove = NodesRemove;
Frame.EdgesAdd = EdgesAdd;
Frame.EdgesRemove  =EdgesRemove;

GraphLayout.Frames{end+1} = Frame;


end % GraphLayoutAddFrame


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DefaultInput  = GetDefaultInput()
DefaultInput = {};
DefaultInput    =   FIOAddParameter(DefaultInput,'Algorithm',CreateAlgorithmProperties('Algorithm','None','LayoutTimeOut',0,'LabelAdjustTimeOut',0));
DefaultInput    =   FIOAddParameter(DefaultInput,'Preview',CreatePreviewProperties({'SHOW_NODE_LABELS','EDGE_CURVED','NODE_LABEL_PROPORTIONAL_SIZE'}, {true, false,false}  ));
DefaultInput    =   FIOAddParameter(DefaultInput,'NodeProperties',CreateNodeProperties([],20,[0.7 0.7 0.7],12));
DefaultInput    =   FIOAddParameter(DefaultInput,'EdgeProperties',CreateEdgeProperties([],[0.7 0.7 0.7]));
DefaultInput    =   FIOAddParameter(DefaultInput,'NodesAdd',[]);
DefaultInput    =   FIOAddParameter(DefaultInput,'NodesRemove',[]);
DefaultInput    =   FIOAddParameter(DefaultInput,'EdgesAdd',[]);
DefaultInput    =   FIOAddParameter(DefaultInput,'EdgesRemove',[]);



end % GetDefaultInput()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

