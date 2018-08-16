function DynamicProcess = DynamicProcessInitialize(Graph,NodeIDs, InitialStates, StateTransition, IterationComplete, varargin)
% Initialize dynamic process. Creates DynamicProcess struct used to actually run the process later.
%
% Receives:
%   Graph - structure - the graph created with GraphLoad or some GraphCreate/GraphGenerate method.
%   NodeIDs - Nx1, vector of integers - List of node IDs. Must be a superset of nodes in Graph.
%           - N, integer - number of nodes. Must be larger/equal than the maxiumal node ID in Graph
%   InitialStates - matrix - matrix NxK of any numeric type representing the initial state of each node. For multi-dimantional, complex states, K>1.
%                            Regular SIR would imply K=1 and InitialStates contains integer values of (1-2-3) for (S-I-R)
%                 - function pointer - a pointer to the user function to be called for each of the nodes as it is initialized. The function prototype is as follows:
%                       [States,UserData] = f(DynamicProcess, NodeID, UserData);
%                           States - 1xK vector of the NodeID's states.
%                           UserData - is an object (of any type) where the method can store whatever information is needs to preserve between calls. For instance, the number of nodes in every state. The value of UserData is going to be collected by the calling method and send back to the user function again. Initially, UserData is the value provided to DynamicProcessInitialize (its default: []);
%    
%   StateTransition - function pointer - a pointer to user callback that is activated for every node each time step. 
%                [States, UserData] =  f(DynamicProcess,NodeID,States, NeighborIDs, LinkWeights,NeighborStates,UserData);
%   IterationComplete - function pointer - (optional) Called at the end of every iteration. Allows the user to summarize or log iteration results. Default: []
%                    [UserData] =  f(DynamicProcess,UserData);
%    varargin - list of arguments -
%             RandomSeed - float - (optional) random seed number. Used to generate reproducable results. Default - []. RandomSeed  not initialzed. 
%             ShuffleNodes - boolean - (optional) whether to randomize the order of node activation during every iteration. Default: true. 
%             UserData     - any - (optional) arbitrary data repeatedly sent by the frameworks to the callback methods. This field can be used to preserve  arbitrary information  between calls. Default: []
%               
%
% Returns:
%   DynamicProcess - struct - the struct containing the information necessary to run the simulation
%
% See Also:
%   GraphLoad, GraphIO, DynamicProcessInitializeSI, GetDefaultInputInitialize
%
% Example:
%   Graph = mexGraphCreateRandomGraph(1000,[1 : 200],[1 : 200].^-2);
%   NodeIDs = [1 : 1000].';
%   InitialStates = zeros(size(NodeIDs), 'uint8');
%   StateTransition = [];
%   IterationComplete  = [];
%   DynamicProcess = DynamicProcessInitialize(Graph,NodeIDs,InitialStates,StateTransition,IterationComplete);
%
% Created:
% Lev Muchnik    06/03/2012
%

error(nargchk(5,inf,nargin));
error(nargoutchk(0,1,nargout));

if ~FIOProcessInputParameters(varargin,GetDefaultInputInitialize),    error('The function input is not FlexIO compatible'); end
DynamicProcess = [];
DynamicProcess.About = 'Dynamic Process';
% DynamicProcess.GraphOriginal = Graph;
DynamicProcess.Parameters = struct('RandomSeed',RandomSeed,'ShuffleNodes',ShuffleNodes);
if ~isempty(DynamicProcess.Parameters.RandomSeed), rng(DynamicProcess.Parameters.RandomSeed); end
if numel(NodeIDs)==1, NodeIDs =rot90(1: NodeIDs,3); end

DynamicProcess.Graph = DynamicProcessConvertGraph(Graph,NodeIDs);
DynamicProcess.UserData = UserData;
DynamicProcess.Time = 0; % iterations counter. 
DynamicProcess.InitialStates = InitialStates;
DynamicProcess.StateTransition = StateTransition;
DynamicProcess.IterationComplete = IterationComplete;
DynamicProcess.Parameters.NumberOfNodes = numel(DynamicProcess.Graph.NodeIDs);

if isnumeric(DynamicProcess.InitialStates) && size(DynamicProcess.InitialStates,1)== numel(DynamicProcess.Graph.NodeIDs)
    % detailed states provided
    DynamicProcess.States = InitialStates;
elseif isa(InitialStates,'function_handle')
    if DynamicProcess.Parameters.ShuffleNodes, SO = randperm(numel(DynamicProcess.Graph.NodeIDs)); 
    else SO = 1:numel(DynamicProcess.Graph.NodeIDs);  end
    
    [States, DynamicProcess.UserData] =  InitialStates(DynamicProcess,DynamicProcess.Graph.NodeIDs(SO(1)),DynamicProcess.UserData);
    if islogical(States), DynamicProcess.States = false( numel(DynamicProcess.Graph.NodeIDs), numel(States));
    else DynamicProcess.States = zeros( numel(DynamicProcess.Graph.NodeIDs), numel(States), class(States)); end
    DynamicProcess.States(SO(1),:) = States; 
    
    for i = 2 : numel(DynamicProcess.Graph.NodeIDs)
        [DynamicProcess.States(SO(i),:), DynamicProcess.UserData ] = DynamicProcess.InitialStates(DynamicProcess,DynamicProcess.Graph.NodeIDs(SO(i)),DynamicProcess.UserData);
    end
else
    error('invalid dimentions or type for ''InitialStates''');
end
if ~isempty( DynamicProcess.IterationComplete), DynamicProcess.UserData = DynamicProcess.IterationComplete(DynamicProcess,DynamicProcess.UserData); end
end % DynamicProcessInitialize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
