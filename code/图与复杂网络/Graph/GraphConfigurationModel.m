function Graph = GraphConfigurationModel(Graph, RemoveLoops)
% Implements configuration model. Returns the graph with the same node degrees, but randomized links. Graph may contain loops (links to the same node). 
% the number of links may slightly differ since duplicate links may appear after reconfiguration. These duplicates are removed. 
% If the graph is undirected, it will remain undirected (see: isUndirected = GraphIsUndirected(Graph))
% Link weights are dropped and set to 1. Nodes in the generated graph may have slightly lower degree because:
%  a. they may evolve two identical links (i,j) - same source, same destination and loose one of these links
%  b. (if loops are removed) loops are not compensated. 
%
% Receives:
%   Graph - structure - see GraphLoad
%   RemoveLoops - boolean - (optional) self-links are removed if true.  
%
%
% Returns: 
%   Graph - structure - see GraphLoad
% 
%
% See Also:
%   GraphIsUndirected, GraphRemoveDuplicateLinks

Graph = GraphRemoveDuplicateLinks(Graph); 

isUndirected = GraphIsUndirected(Graph);
if isUndirected
    Links = Graph.Data(Graph.Data(:,1)<=Graph.Data(:,2),1:2); 
else % directed
    Links = Graph.Data(:,1:2);         
end

Graph.Data = [Links(:,1) Links(randperm(size(Links,1)),2) ones(size(Links,1),1)];

if isUndirected
    Graph = GraphMakeUndirected(Graph); 
    Graph = GraphRemoveDuplicateLinks(Graph); 
end

if RemoveLoops
    Graph.Data = Graph.Data(Graph.Data(:,1)~=Graph.Data(:,2),:); 
end

error('not yet implemented'); 

% remove duplicate links. 