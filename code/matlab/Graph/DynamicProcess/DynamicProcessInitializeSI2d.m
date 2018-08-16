function DynamicProcess =DynamicProcessInitializeSI2d(Graph,NodeIDs, InitialInfectionDensity, SpontaniousInfectionRate, InfectionTransferRate, varargin)
% Calls DynamicProcessInitialize to create SI (Susceptible-Infected ) model simulation of N exclusive infections. 
%
% Receives: 
%   NodeIDs  - interger(s) - vector of node ids or the number of IDs. If empty, NodeIDs <- 1 :  max(max(Graph.Data(:,1:2)))
%   InitialInfectionDensity - nx1, 0..1 - probability of a node to be infected at time=0
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
%   InitialInfectionDensity = [N-4 2 2]; 
%   InfectionTransferRate = [ [ 1 0 0]; [0 1/50 0]; [ 0 0 1/100] ];
%   SpontaniousInfectionRate = [ [1 0 0 ]; [0 1 0]; [0 0 1]];
%   
%   DynamicProcess =DynamicProcessInitializeSI2d(Graph, N, InitialInfectionDensity,SpontaniousInfectionRate,InfectionTransferRate );
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
InitialInfectionDensity  =cumsum(InitialInfectionDensity/sum(InitialInfectionDensity));
for i =  1 : size(SpontaniousInfectionRate,1)
   SpontaniousInfectionRate(i,:) = cumsum(SpontaniousInfectionRate(i,:)/sum(SpontaniousInfectionRate(i,:))); 
end
for i = 1 : size(InfectionTransferRate,1)
    % InfectionTransferRate(i,:) = cumsum(InfectionTransferRate(i,:)/sum(InfectionTransferRate(i,:)));
    InfectionTransferRate(i,:) = InfectionTransferRate(i,:)/sum(InfectionTransferRate(i,:));
end
UserData = struct('InitialInfectionDensity',InitialInfectionDensity, 'SpontaniousInfectionRate',SpontaniousInfectionRate, 'InfectionTransferRate',InfectionTransferRate,'NumberOfStates',size(InfectionTransferRate,2));
UserData.TimeLine = zeros(UserData.NumberOfStates+1,0); 
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
% States = find(rand(1)<UserData.InitialInfectionDensity, 1,'last');
% if isempty(States), States = 0; end
if numel(UserData.InitialInfectionDensity)~=DynamicProcess.Parameters.NumberOfNodes
    States = find(rand(1)<UserData.InitialInfectionDensity, 1,'first')-1;
else
    States = UserData.InitialInfectionDensity(NodeID);
end
end

function [UserData] = DynamicProcessIterationCompleteSI(DynamicProcess,UserData)
% initializes the node states for SI (susceptible infected) model. This method is called by DynamicProcessInitialize.m
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes
%
Res = zeros(UserData.NumberOfStates+1,1);
for i =0 : UserData.NumberOfStates
    Res(i+1) = nnz(DynamicProcess.States==i);
end
UserData.TimeLine(:,end+1) = Res;
end


function [States,UserData] = DynamicProcessStateTransitionSI(DynamicProcess,NodeID,States, NeighborIDs,LinkWeights, NeighborStates,UserData)
% performes transition of states from susceptible to infected in the classical SI model. UserData must contain .SpontaniousInfectionRate and .InfectionTransferRate
%
% Receives:
%   DynamicProcess
%   NodeID
%   UserData  - struct - see DynamicProcessInitializeSI for details. This method uses UserData.InitialInfectionDensity to seelct intial infected nodes 
%               
OldState = DynamicProcess.States(NodeID); 
StateCounts = hist(double(NeighborStates),0 : UserData.NumberOfStates-1);
1 - ( 1-UserData.InfectionTransferRate(OldState+1,:)).^StateCounts
% States = find((R < ((1-power(1-UserData.SpontaniousInfectionRate(OldState+1,:),)))),1,'first')-1;
% 
% StatesOrder = randperm(UserData.NumberOfStates+1)-1;
% % States = find(rand(1) <  (UserData.SpontaniousInfectionRate(States+1,:)),1,'first');
%
% States = find((R < ((1-power(1-UserData.InfectionTransferRate(States+1,:),nnz(NeighborStates==StatesOrder(i)))))),1,'first')-1;
% 
% for i = 1 : UserData.NumberOfStates+1
%     R = rand(1);
%     if nnz(NeighborStates==StatesOrder(i))
%         States = find((R < ((1-power(1-UserData.InfectionTransferRate(States+1,:),nnz(NeighborStates==StatesOrder(i)))))),1,'first')-1;
%     end
%     if isempty(States), States = 0; end
% end
% if ~States % only process if susceptible
%     States = find((rand(1)< (UserData.SpontaniousInfectionRate(States+1,:) +(1-power(1-UserData.InfectionTransferRate(States+1,:),nnz(NeighborStates))))),1,'last');
%     if isempty(States), States = 0; end
%     if rand(1)<UserData.SpontaniousInfectionRate
%         States = true; % spontanious infection
%     else
%         States = (rand(1)<1-power(1-UserData.InfectionTransferRate,nnz(NeighborStates)));
%     end    
% end
end