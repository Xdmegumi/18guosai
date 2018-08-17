function [Graph, varargout]=GraphCreateSmallWorld(N,K,pbeta)
% Create the small-world graph according th Watts & Strogatz (1998)
%
% Receives:
%   N  - number of nodes in graph
%   K  - degree of each node. Must be even
%   pbeta - probability to rewire degree. 
%
% Returns:
%   Greaph - struct - see LoadGraph
%   varargout - optional
%       number of rewired links
%
% See Also:
%   GraphLoad
% 
% Example:
%{
   [Graph, NumberOfRewired] =GraphCreateSmallWorld(10,4,0.1)
%}

narginchk(3,3);
nargoutchk(0,2);

if mod(K,2)==1, error('Parameter K (%d) must be even', K); end

Links = zeros(N*K/2,2);
edge = 1;
for i = 1 : N
%     for j = i-K/2 : i-1
%         if j>0
%             Links(edge,:) = [j i];
%         else
%             Links(edge,:) = [i j+N];
%         end
%         edge =edge+1;
%     end
    for j = i+1 : i+K/2 
        if j <= N
            Links(edge,:) = [i j];
        else
            Links(edge,:) = [j-N i];                 
        end
        edge =edge+1;       
    end
end
Links = sort(Links,2);
edge =1;
NumberOfRewired = 0; 
for i = 1 : N
    for j = i+1 : i+K/2 
        if rand(1,1)<pbeta
            NewEdge = sort([i randi(N,1)]);
            if NewEdge(1)~=NewEdge(2) && nnz(Links(:,1)==NewEdge(1) & Links(:,2)==NewEdge(2))==0
                Links(edge,:) = NewEdge;
                NumberOfRewired  = NumberOfRewired +1;
            end
        end
        edge =edge+1;       
    end
end

Graph = GraphLoad(Links,[],false); 
Graph.Signature{end+1} = mfilename;
Graph  = GraphMakeUndirected(Graph);
if nargout>1, varargout{1} = 2*NumberOfRewired ; end
