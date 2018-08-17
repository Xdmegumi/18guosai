function DynamicProcess =DynamicProcessInitializeSIS(Graph,NodeIDs, InitialInfectionDensity, SpontaniousInfectionRate, InfectionTransferRate, RecoveryRate, varargin)
% Calls DynamicProcessInitialize to create SIS (susceptible–infected–susceptible) model simulation, where infected nodes (see SI) recover at rate mu (RecoveryRate) and become susceptible again (unlike SIR when they are permanently removed at rate mu).
%
% Receives: 
%   NodeIDs  - interger(s) - vector of node ids or the number of IDs. If empty, NodeIDs <- 1 :  max(max(Graph.Data(:,1:2)))
%   InitialInfectionDensity - double, 0..1 - probability of a node to be infected at time=0
%   SpontaniousInfectionRate - double 0..1 - probability of a node to become infected at every iteration
%   InfectionTransferRate - double 0..1 - probability of infection transfer from infected to suseptible node at every iteration, usually nominated as beta. 
%   RecoveryRate - double 0..1 - probability of the infected node to recover and become susceptible again (usually refered to as mu). 
%   varargin - see DynamicProcessInitialize  
%
% Returns:
%   DynamicProcess  - struct . See DynamicProcessInitialize . 
%
% Example:
%   N = 10000;
%   Graph = mexGraphCreateRandomGraph(N,[1 : 200],[1 : 200].^-2);
%   N = max(N, max(max(Graph.Data(:,1:2))));
%   DynamicProcess =DynamicProcessInitializeSIS(Graph, N, 1/300, 1/100, 1/50,1/50);
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
UserData = struct('InitialInfectionDensity',InitialInfectionDensity, 'SpontaniousInfectionRate',SpontaniousInfectionRate, 'InfectionTransferRate',InfectionTransferRate,'RecoveryRate',RecoveryRate);
DynamicProcess =DynamicProcessInitialize(Graph,NodeIDs, @DynamicProcessInitializeStatesSIS, @DynamicProcessStateTransitionSIS, @DynamicProcessIterationCompleteSIS, 'UserData',UserData,'ShuffleNodes',ShuffleNodes,'RandomSeed',RandomSeed );

end

function [States,UserData] = DynamicProcessInitializeStatesSIS(DynamicProcess, NodeID, UserData)
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


function [UserData] = DynamicProcessIterationCompleteSIS(DynamicProcess,UserData)
% initializes the node states for SI (susceptible infected) model. This method is called by DynamicProcessInitialize.m
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               
end


function [States,UserData] = DynamicProcessStateTransitionSIS(DynamicProcess,NodeID,States, NeighborIDs,LinkWeights, NeighborStates,UserData)
% performes transition of states from susceptible to infected in the classical SI model. UserData must contain .SpontaniousInfectionRate and .InfectionTransferRate
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               

if States  % susceptible. become infected? 
   States  =  (rand(1)< (UserData.SpontaniousInfectionRate +(1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates))))); 
else % infected. become susceptible?
   States   = ~( rand(1) < UserData.RecoveryRate);
end
end