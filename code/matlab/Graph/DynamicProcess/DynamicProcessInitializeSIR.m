function DynamicProcess =DynamicProcessInitializeSIR(Graph,NodeIDs, InitialInfectionDensity, SpontaniousInfectionRate, InfectionTransferRate, NodeRemovalRate, varargin)
% Calls DynamicProcessInitialize to create SIR (susceptible–infected–removed) model simulation, where infected nodes (see SI) are removed (i.e. stop spreeading the infection like in SI and can't be later infected like in SIS) at a rate mu. 
%
% Receives: 
%   NodeIDs  - interger(s) - vector of node ids or the number of IDs. If empty, NodeIDs <- 1 :  max(max(Graph.Data(:,1:2)))
%   InitialInfectionDensity - double, 0..1 - probability of a node to be infected at time=0
%   SpontaniousInfectionRate - double 0..1 - probability of a node to become infected at every iteration
%   InfectionTransferRate - double 0..1 - probability of infection transfer from infected to suseptible node at every iteration, usually nominated as beta. 
%   NodeRemovalRate - double 0..1 - probability of the infected node to be permanently removed (usually refered to as mu). 
%   varargin - see DynamicProcessInitialize  
%
% Returns:
%   DynamicProcess  - struct . See DynamicProcessInitialize . 
%
% Example:
%   N = 100000;
%   Graph = mexGraphCreateRandomGraph(N,[1 : 200],[1 : 200].^-2);
%   N = max(N, max(max(Graph.Data(:,1:2))));
%   DynamicProcess =DynamicProcessInitializeSIR(Graph, N, 1/300, 1/100, 1/50, 1/50);
%   DynamicProcess = DynamicProcessIterate(DynamicProcess,1);
%
% See Also:
%   DynamicProcessInitialize, GetDefaultInputInitialize
%
% Reference:
%   Barrat, Alain, Marc Barthelemy, and Alessandro Vespignani (2008), Dynamical processes on complex networks: Cambridge University Press. p 185
%
% Created:
% Lev Muchnik    07/03/2012
%

error(nargchk(5,inf,nargin));
error(nargoutchk(0,1,nargout));

if ~FIOProcessInputParameters(varargin,GetDefaultInputInitialize),    error('The function input is not FlexIO compatible'); end
if isempty(NodeIDs), NodeIDs = 1 :  max(max(Graph.Data(:,1:2))); end
UserData = struct('InitialInfectionDensity',InitialInfectionDensity, 'SpontaniousInfectionRate',SpontaniousInfectionRate, 'InfectionTransferRate',InfectionTransferRate,'NodeRemovalRate',NodeRemovalRate);
DynamicProcess =DynamicProcessInitialize(Graph,NodeIDs, @DynamicProcessInitializeStatesSIR, @DynamicProcessStateTransitionSIR, @DynamicProcessIterationCompleteSIR, 'UserData',UserData,'ShuffleNodes',ShuffleNodes,'RandomSeed',RandomSeed );

end

function [States,UserData] = DynamicProcessInitializeStatesSIR(DynamicProcess, NodeID, UserData)
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

States = uint8(rand(1)<UserData.InitialInfectionDensity);
end


function [UserData] = DynamicProcessIterationCompleteSIR(DynamicProcess,UserData)
% initializes the node states for SI (susceptible infected) model. This method is called by DynamicProcessInitialize.m
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               
end


function [States,UserData] = DynamicProcessStateTransitionSIR(DynamicProcess,NodeID,States, NeighborIDs,LinkWeights, NeighborStates,UserData)
% performes transition of states from susceptible to infected in the classical SI model. UserData must contain .SpontaniousInfectionRate and .InfectionTransferRate
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               

switch States 
    case 0 % susceptible
        if (rand(1)< (UserData.SpontaniousInfectionRate +(1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates))))), States =  uint8(1); end
    case 1
        if (rand(1) < UserData.NodeRemovalRate), States = uint8(2); end
end
% if ~States % only process if susceptible
%     States = (rand(1)< (UserData.SpontaniousInfectionRate +(1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates)))));
% %     if rand(1)<UserData.SpontaniousInfectionRate
% %         States = true; % spontanious infection
% %     else
% %         States = (rand(1)<1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates)));
% %     end    
% end
end