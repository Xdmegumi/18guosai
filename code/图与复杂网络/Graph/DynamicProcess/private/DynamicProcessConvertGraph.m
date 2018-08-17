function DynamicProcessGraph = DynamicProcessConvertGraph(Graph,NodeIDs)
% transforms the graph to the data structure optimized for Dynamic Process library use. 
% Receives 
%   Graph - struct - the graph created with GraphLoad 
%   NodeIDs - vector of integers - list of node IDs.  Must be a superset of nodes in Graph. 
%   
% Returns 
%   DynamicProcessConvertGraph - struct - graph structure optimized for the Dynamic Process library
%
% See Also:
%   DynamicProcessInitialize - struct -- contains inverse links structure. 
% 
% Created:
% Lev Muchnik    06/03/2012
%

error(nargchk(1,inf,nargin));
error(nargoutchk(0,1,nargout));


DynamicProcessGraph = [];
DynamicProcessGraph.About = 'Dynamic Process Graph';
DynamicProcessGraph.NodeIDs = uint32(NodeIDs(:));

LinkedNodeIDs = uint32(fast_unique(reshape(Graph.Data(:,1:2), 2*size(Graph.Data,1),1)));
if ~isempty(fast_setdiff_sorted(LinkedNodeIDs, DynamicProcessGraph.NodeIDs)), error('%d nodes are not defined in NodeIDs parameter',numel(fast_setdiff_sorted(LinkedNodeIDs, DynamicProcessGraph.NodeIDs))); end
clear ('LinkedNodeIDs');

[y x] = fast_frequency(uint32(Graph.Data(:,2)));
[~, ai, bi] = fast_intersect_sorted(x,DynamicProcessGraph.NodeIDs);
DynamicProcessGraph.Kin = zeros(size(DynamicProcessGraph.NodeIDs),'uint32');
DynamicProcessGraph.Kin(bi) = y(ai);
clear('x','y','ai','bi');
DynamicProcessGraph.Indeces = uint32([0; cumsum(double(DynamicProcessGraph.Kin))]); 
[~, SO] = sort(Graph.Data(:,2));
SourceNodes = uint32(Graph.Data(SO,1));
WeightsNodes = Graph.Data(SO,3);
DynamicProcessGraph.Neighbors = zeros(DynamicProcessGraph.Indeces(end),1,'uint32');
DynamicProcessGraph.Weights = zeros(DynamicProcessGraph.Indeces(end),1);
for i = 1 : numel(DynamicProcessGraph.Kin)
    Indeces = DynamicProcessGraph.Indeces(i) + 1 : DynamicProcessGraph.Indeces(i+1);
    [DynamicProcessGraph.Neighbors(Indeces ), SO] = sort(SourceNodes(Indeces));
    DynamicProcessGraph.Weights(Indeces) = WeightsNodes(Indeces(SO));
end
clear('SourceNodes');

