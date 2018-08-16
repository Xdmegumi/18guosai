function AlgorithmProperties = CreateAlgorithmProperties(varargin)
% Used to provide details for the graph layout algorithm
%
% Receives:
%   varargin        -   FLEX IO -   The input is in FlexIO format.  The following parameters are allowed:
%                                       Parameter Name          |  Type         |  Optional |   Default Value |   Description
%                                         LayoutTimeOut         |   double      |  yes      |    10.0         | the maximal time to run the layout  algorithm
%                                         Algorithm             |   struct      |  yes      |  see below      | the name and settings of the algorithm to execute. Can be ForceAtlas, ForceAtlas2, YifanHuLayout. 
%                                               .AlgorithmName = 'ForceAtlas2';
%                                               .PropertyNames = {'','','',''};
%                                               .PropertyValues = {'','','',''};
%                                       None  - no layout algorithm is run. 
%                                       ForceAtlas2 - http://gephi.org/docs/toolkit/org/gephi/layout/plugin/forceAtlas2/ForceAtlas2.html
%                                           AdjustSizes - bool - ???  http://forum.gephi.org/viewtopic.php?t=1679
%                                           BarnesHutOptimize - bool - 
%                                           BarnesHutTheta - double 
%                                           EdgeWeightInfluence - double
%                                           Gravity - double
%                                           JitterTolerance - double
%                                           LinLogMode - bool 
%                                           OutboundAttractionDistribution - bool
%                                           ScalingRatio - double
%                                           StrongGravityMode - bool
%                                           ThreadsCount - int 
%                                           
%                                       Supported values for YifanHuLayout: http://gephi.org/docs/toolkit/index.html?org/gephi/layout/plugin/force/yifanHu/YifanHuLayout.html
%                                           StepDisplacement  - long - 1f
%                                           AdaptiveCooling - bool - true
%                                           BarnesHutTheta - float
%                                           ConvergenceThreshold - float - 1e-4
%                                           InitialStep - float  - 20.0
%                                           OptimalDistance - float - 100.0 
%                                           QuadTreeMaxLevel  - int - 10
%                                           RelativeStrength - float - 0.2
%                                           StepRatio - float - 0.95
%
%                                       ForceAtlas   - http://gephi.org/docs/toolkit/index.html?org/gephi/layout/plugin/force/yifanHu/YifanHuLayout.html
%                                           AdjustSize - boolean - false
%                                           AttractionStrength - double - 80.0
%                                           Cooling - double - ?? 
%                                           FreezeBalance - bool - ?? 
%                                           FreezeInertia - double - ??
%                                           FreezeStrength - double - ??
%                                           Gravity  -double - 30.0
%                                           Inertia  -double - 0.1
%                                           MaxDisplacement  -double - 10.0
%                                           OutboundAttractionDistribution - bool - false
%                                           RepulsionStrength - double - 200.0
%
%                                       LabelAdjustTimeOut      |  double       |  yes      |    1.0         | time to spend on lable adjustment algorithm. Set to 0 to prevent label adjustment
%
%
%
% See Also:
%   GraphLoad, GraphLayoutAddFrame, GraphLayoutDraw
%
%

%% test input  + defaults
narginchk(0,inf);
nargoutchk(0,1);

if ~FIOProcessInputParameters(GetDefaultInput)
    error('The default input is not FlexIO compatible');
end
if ~FIOProcessInputParameters(varargin)
    error('The input is not FlexIO compatible');
end

% AlgorithmProperties.AlgorithmName = Algorithm.AlgorithmName;
% AlgorithmProperties.LayoutTimeOut = LayoutTimeOut;
if ischar(Algorithm)
    Algorithm = struct('AlgorithmName',Algorithm); 
    Algorithm.PropertyNames = {};
    Algorithm.PropertyValues = {}; 
end
AlgorithmProperties.Algorithm = Algorithm;
AlgorithmProperties.Algorithm.LayoutTimeOut =LayoutTimeOut;
AlgorithmProperties.LabelAdjustTimeOut = LabelAdjustTimeOut; 

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DefaultInput  = GetDefaultInput()
DefaultInput = {};
DefaultInput    =   FIOAddParameter(DefaultInput,'LayoutTimeOut',10.0);
DefaultInput    =   FIOAddParameter(DefaultInput,'LabelAdjustTimeOut',1.0);

Algorithm = [];
Algorithm.AlgorithmName = 'ForceAtlas2';
Algorithm.PropertyNames = {'AdjustSizes','LinLogMode','ThreadsCount', 'OutboundAttractionDistribution'};
Algorithm.PropertyValues = {true, true, 2, true};
DefaultInput    =   FIOAddParameter(DefaultInput,'Algorithm',Algorithm);

end % GetDefaultInput()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
