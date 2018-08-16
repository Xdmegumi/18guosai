function DynamicProcess =DynamicProcessInitializeSI(Graph,NodeIDs, InitialInfectionDensity, SpontaniousInfectionRate, InfectionTransferRate, varargin)
% Calls DynamicProcessInitialize to create SI (Susceptible-Infected ) model simulation
%
% Receives: 
%   NodeIDs  - interger(s) - vector of node ids or the number of IDs. If empty, NodeIDs <- 1 :  max(max(Graph.Data(:,1:2)))
%   InitialInfectionDensity - double, 0..1 - probability of a node to be infected at time=0
%   SpontaniousInfectionRate - double 0..1 - probability of a node to become infected at every iteration
%   InfectionTransferRate - double 0..1 - probability of infection transfer from infected to suseptible node at every iteration, usually nominated as beta. 
%   varargin - see DynamicProcessInitialize  
%
% Returns:
%   DynamicProcess  - struct . See DynamicProcessInitialize . 
%
% Example:
%   N = 100000;
%   Graph = mexGraphCreateRandomGraph(N,[1 : 200],[1 : 200].^-2);
%   N = max(N, max(max(Graph.Data(:,1:2))));
%   DynamicProcess =DynamicProcessInitializeSI(Graph, N, 1/300, 1/100, 1/50);
%   DynamicProcess = DynamicProcessIterate(DynamicProcess,1);
%
% See Also:
%   DynamicProcessInitialize, GetDefaultInputInitialize
%
% Reference:
%   Barrat, Alain, Marc Barthelemy, and Alessandro Vespignani (2008), Dynamical processes on complex networks: Cambridge University Press. p. 184
%
% Created:
% Lev Muchnik    06/03/2012
%

error(nargchk(5,inf,nargin));
error(nargoutchk(0,1,nargout));

if ~FIOProcessInputParameters(varargin,GetDefaultInputInitialize),    error('The function input is not FlexIO compatible'); end
if isempty(NodeIDs), NodeIDs = 1 :  max(max(Graph.Data(:,1:2))); end
UserData = struct('InitialInfectionDensity',InitialInfectionDensity, 'SpontaniousInfectionRate',SpontaniousInfectionRate, 'InfectionTransferRate',InfectionTransferRate);
% UserData.NodeIDs
% UserData.TimeLine =-ones(numel(NodeIDs), 1,'int32'); % each element of the vector contains the time when it became infected. -1 representes nodes that where never infected. 
DynamicProcess =DynamicProcessInitialize(Graph,NodeIDs, @DynamicProcessInitializeStatesSI, @DynamicProcessStateTransitionSI, @DynamicProcessIterationCompleteSI, 'UserData',UserData,'ShuffleNodes',ShuffleNodes,'RandomSeed',RandomSeed );

end

function [States,UserData] = DynamicProcessInitializeStatesSI(DynamicProcess, NodeID, UserData)
% initializes the node states for SI (susceptible infected) model. This method is called by DynamicProcessInitialize.m
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               uses .InitialInfectionDensity to initialize each node. 
%
%
%
%
% See Also:
%   DynamicProcessInitialize, GetDefaultInputInitialize
%
% Created:
% Lev Muchnik    06/03/2012
%

States = rand(1)<UserData.InitialInfectionDensity;
end


function [UserData] = DynamicProcessIterationCompleteSI(DynamicProcess,UserData)
% initializes the node states for SI (susceptible infected) model. This method is called by DynamicProcessInitialize.m
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               
if ~isfield(UserData,'TimeLine')
   UserData.TimeLine = -ones(size(DynamicProcess.States),'int32'); 
end
UserData.TimeLine(DynamicProcess.States & UserData.TimeLine==-1)  = int32(DynamicProcess.Time);
end


function [States,UserData] = DynamicProcessStateTransitionSI(DynamicProcess,NodeID,States, NeighborIDs,LinkWeights, NeighborStates,UserData)
% performes transition of states from susceptible to infected in the classical SI model. UserData must contain .SpontaniousInfectionRate and .InfectionTransferRate
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               


if ~States % only process if susceptible
    States = (rand(1)< (UserData.SpontaniousInfectionRate +(1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates)))));
%     if rand(1)<UserData.SpontaniousInfectionRate
%         States = true; % spontanious infection
%     else
%         States = (rand(1)<1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates)));
%     end    
end
end