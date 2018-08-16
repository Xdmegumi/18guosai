function NodeProperties = CreateNodeProperties( NodeIDs,  Color, Size, LabelSize)
% Structure used to specify characteristics of the subset of edges
%
% Receives:
%   NodeIDs - vector - list of node ids in the Graph.Data for which this structure will be applied. Set to [] if it's default node  properties.
%   Size - double - size of the node
%   Color - color of the node
%   LabelSize - integer - size of the label. 
%
% Returns:
%   NodeProperties - structure - specified the node properties. 
%
% See Also: 
%   InitializeGraphLayout

error(nargchk(4,4,nargin));
error(nargoutchk(0,1,nargout));

NodeProperties = [];
NodeProperties.NodeIDs =NodeIDs;
NodeProperties.Size = Size;
NodeProperties.Color = Color;
NodeProperties.Type = 'Node Properties';
NodeProperties.LabelSize = LabelSize;
