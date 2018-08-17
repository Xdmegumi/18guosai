function EdgeProperties = CreateEdgeProperties( Edges, Color, Size)
% Structure used to specify characteristics of the subset of edges
%
% Receives:
%   Edges - vector, m x 2 - list of edges (row numbers) for which this structure will be applied. Set to [] if it's default edge properties. 
%   Color - color of the edge
%   Size - size (width) of the edge. Default: 1
%
% Returns:
%   EdgeProperties - structure - specified the edge properties. 
%
% See Also: 
%   InitializeGraphLayout

error(nargchk(2,3,nargin));
error(nargoutchk(0,1,nargout));
if ~exist('Size','var'), Size = 1; end

EdgeProperties = [];
EdgeProperties.Edges =Edges;
EdgeProperties.Color = Color;
EdgeProperties.Size = Size; 
EdgeProperties.Type = 'Edge Properties';