function DynamicProcess = DynamicProcessIterate(DynamicProcess,NumberOfIterations)
% performs the given number of dynamic process iterations
%
% Rewceives:
%   DynamicProcess -
%   NumberOfIterations - integer - the number of iterations to perform
%
% Returns:
%   DynamicProcess  - struct - the struct containing the information necessary to run the simulation. See DynamicProcessInitialize
%
% Example:
%
%
% See Also:
%   DynamicProcessInitialize
%
%
%
% Created:
% Lev Muchnik    06/03/2012
%
error(nargchk(2,2,nargin));
error(nargoutchk(0,1,nargout));

if ~DynamicProcess.Parameters.ShuffleNodes, SO = 1 : DynamicProcess.Parameters.NumberOfNodes; end
for Time = DynamicProcess.Time+1 : DynamicProcess.Time+NumberOfIterations
    if DynamicProcess.Parameters.ShuffleNodes, SO = randperm(DynamicProcess.Parameters.NumberOfNodes); end
    DynamicProcess.Time = Time;
    UserData = DynamicProcess.UserData;
    for i = 1 : DynamicProcess.Parameters.NumberOfNodes
        NeighbourIndeces =  DynamicProcess.Graph.Indeces(SO(i))+1 : DynamicProcess.Graph.Indeces(SO(i)+1);
        [DynamicProcess.States(SO(i),:), UserData ] = DynamicProcess.StateTransition(DynamicProcess, ...
            DynamicProcess.Graph.NodeIDs(SO(i)), ...
            DynamicProcess.States(SO(i),:), ...
            DynamicProcess.Graph.Neighbors(NeighbourIndeces), ...
            DynamicProcess.Graph.Weights(NeighbourIndeces), ...
            DynamicProcess.States(DynamicProcess.Graph.Neighbors(NeighbourIndeces),:), ...
            UserData);
    end
    DynamicProcess.UserData = DynamicProcess.IterationComplete(DynamicProcess,UserData);
end
end