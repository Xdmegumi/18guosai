function [FileNames, GraphLayout] = GraphLayoutDraw(GraphLayout, GraphName, varargin)
% Initialized graph layout - a structure containing instructions for plotting the graph
%
% Receives:
%   GraphLayout - structure - see GraphLayoutInitialize & GraphLayoutAddFrame
%   GraphName  - string - a name (qualifiable as short file name) of the graph. Will be used as bases for all generated file names.
%   varargin        -   FLEX IO -   The input is in FlexIO format.  The following parameters are allowed:
%                                       Parameter Name          |  Type         |  Optional |   Default Value |   Description
%                                           ExportFileFormat    | string        |  yes      |    png          | the format of the exported image files
%                                           Directed            | boolean       |  yes      |    true         | true if the graph is directed. False - otherwize.
%
%
%
%
%
%
% See Also:
%   GraphLayoutAddFrame, GraphLayoutInitialize
%
%

%% test input  + defaults
narginchk(2,inf);
nargoutchk(0,2);

if ~FIOProcessInputParameters(GetDefaultInput)
    error('The default input is not FlexIO compatible');
end
if ~FIOProcessInputParameters(varargin)
    error('The input is not FlexIO compatible');
end
StartTime =  clock; 
FileNames = cell(size(GraphLayout.Frames));
DeleteFrameFiles(GraphLayout.Parameters.TempFolder,GraphName,ExportFileFormat );
for i =  1 : numel(GraphLayout.Frames)
    FileNames{i} = sprintf('%s%s_%6.6d.%s',GraphLayout.Parameters.TempFolder, GraphName, i,ExportFileFormat );
end
GraphLayout.DrawSettings.Directed = Directed;
GraphLayout.FileName =  sprintf('%s%s.%s',GraphLayout.Parameters.TempFolder, GraphName, 'xml' );
GraphLayout.FrameFileNames = FileNames;
GraphLayout.GraphName = GraphName;
GraphLayout.Export.ExportFileFormat = ExportFileFormat;
CreateLayoutXML(GraphLayout);
GraphLayout.Execution = GraphLayoutRunAlgorithm(GraphLayout);
GraphLayout.LayoutRunTime = etime(clock,StartTime); 
end % GraphLayoutDraw
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Execution = GraphLayoutRunAlgorithm(GraphLayout)
Execution = [];
Execution.CommandLine = sprintf('java -jar "%s" "%s"',GraphLayout.Parameters.JARFileName , GraphLayout.FileName);
[Execution.ExitStatus, Execution.result] = system(Execution.CommandLine);

% !java  -jar "D:\Documents\MFiles\Complexity\Graph\Gephi\gephi-toolkit-0.8.1-all\Netbeans\javaGraphDraw\dist\javaGraphDraw.jar" "d:\Documents\MFiles\Complexity\Graph\Gephi\classpath.txt"
end % GraphLayoutRunAlgorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CreateLayoutXML(GraphLayout)
%% initialize document
documentNode = com.mathworks.xml.XMLUtils.createDocument('GraphDraw');
docRootNode = documentNode.getDocumentElement;
docRootNode.setAttribute('GraphName',GraphLayout.GraphName);
docRootNode.setAttribute('Date',datestr(now));
docRootNode.setAttribute('OriginalFileName',GraphLayout.FileName);
docRootNode.setAttribute('Directed',num2str(GraphLayout.DrawSettings.Directed+0));
%% Graph
GraphElement = documentNode.createElement('Graph');  docRootNode.appendChild(GraphElement);
NodesElement = documentNode.createElement('Nodes');  GraphElement.appendChild(NodesElement);
NodeIDs = unique(GraphLayout.Graph.Data(:,1:2));
NodesElement.setAttribute('Count',num2str(numel(NodeIDs)));
for i = 1 : numel(NodeIDs)
    NodeElement = documentNode.createElement('Node');  NodesElement.appendChild(NodeElement);
    NodeElement.setAttribute('ID',num2str(NodeIDs(i)));
    NodeElement.setAttribute('Name',num2str(NodeIDs(i)));
end
EdgesElement = documentNode.createElement('Edges');  GraphElement.appendChild(EdgesElement);
EdgesElement.setAttribute('Count',num2str(size(GraphLayout.Graph.Data,1)));
for i =1 : size(GraphLayout.Graph.Data,1)
    EdgeElement = documentNode.createElement('Edge');  EdgesElement.appendChild(EdgeElement);
    EdgeElement.setAttribute('ID',num2str(i));
    EdgeElement.setAttribute('From',num2str(GraphLayout.Graph.Data(i,1)));
    EdgeElement.setAttribute('To',num2str(GraphLayout.Graph.Data(i,2)));
    EdgeElement.setAttribute('Weight',num2str(GraphLayout.Graph.Data(i,3)));
end
%% frames
FramesElement = documentNode.createElement('Frames');  docRootNode.appendChild(FramesElement);
FramesElement.setAttribute('Count',num2str(numel(GraphLayout.Frames)));
for i =1 : numel(GraphLayout.Frames)
    FrameElement = documentNode.createElement('Frame');  FramesElement.appendChild(FrameElement);
    FrameElement.setAttribute('Index',num2str(i));
    FrameElement.setAttribute('FileName',GraphLayout.FrameFileNames{i});
    
    NodesAddElement = documentNode.createElement('NodesAdd');  FrameElement.appendChild(NodesAddElement);
    NodesAddElement.setAttribute('Count',num2str(numel( GraphLayout.Frames{i}.NodesAdd)));
    NodesAddElement.appendChild(documentNode.createTextNode( num2str(GraphLayout.Frames{i}.NodesAdd)));
    
    NodesRemoveElement = documentNode.createElement('NodesRemove');  FrameElement.appendChild(NodesRemoveElement);
    NodesRemoveElement.setAttribute('Count',num2str(numel( GraphLayout.Frames{i}.NodesAdd)));
    NodesRemoveElement.appendChild(documentNode.createTextNode( num2str(GraphLayout.Frames{i}.NodesRemove )));
    
    EdgesAddElement = documentNode.createElement('EdgesAdd');  FrameElement.appendChild(EdgesAddElement);
    EdgesAddElement.setAttribute('Count',num2str(numel( GraphLayout.Frames{i}.EdgesAdd  )/2));
    EdgesAddElement.appendChild(documentNode.createTextNode( num2str(GraphLayout.Frames{i}.EdgesAdd(:))));
    
    EdgesRemoveElement = documentNode.createElement('EdgesRemove');  FrameElement.appendChild(EdgesRemoveElement);
    EdgesRemoveElement.setAttribute('Count',num2str(numel( GraphLayout.Frames{i}.EdgesRemove)/2));
    EdgesRemoveElement.appendChild(documentNode.createTextNode( num2str(GraphLayout.Frames{i}.EdgesRemove(:) )));
    
    NodesPropertiesElement = documentNode.createElement('NodesProperties');  FrameElement.appendChild(NodesPropertiesElement);
    NodesPropertiesElement.setAttribute('Count', num2str(numel(GraphLayout.Frames{i}.NodeProperties)));
    for j = 1 : numel(GraphLayout.Frames{i}.NodeProperties)
        CurrentNodesPropertiesElement = documentNode.createElement('NodesProperties');  NodesPropertiesElement.appendChild(CurrentNodesPropertiesElement);
        CurrentNodesPropertiesElement.setAttribute('Index',num2str(j));
        CurrentNodesPropertiesElement.setAttribute('Size', num2str(GraphLayout.Frames{i}.NodeProperties{j}.Size));
        CurrentNodesPropertiesElement.setAttribute('Color', num2str(GraphLayout.Frames{i}.NodeProperties{j}.Color));
        CurrentNodesPropertiesElement.setAttribute('Count', num2str(numel(GraphLayout.Frames{i}.NodeProperties{j}.NodeIDs)));
        CurrentNodesPropertiesElement.setAttribute('LabelSize', num2str(GraphLayout.Frames{i}.NodeProperties{j}.LabelSize));
        CurrentNodesPropertiesElement.appendChild(documentNode.createTextNode(num2str(GraphLayout.Frames{i}.NodeProperties{j}.NodeIDs(:).')));
    end
    
    EdgsPropertiesElement = documentNode.createElement('EdgesProperties');  FrameElement.appendChild(EdgsPropertiesElement);
    EdgsPropertiesElement.setAttribute('Count', num2str(numel(GraphLayout.Frames{i}.EdgeProperties)));
    for j = 1 : numel(GraphLayout.Frames{i}.EdgeProperties)
        CurrentEdgesPropertiesElement = documentNode.createElement('EdgesProperties');  EdgsPropertiesElement.appendChild(CurrentEdgesPropertiesElement);
        CurrentEdgesPropertiesElement.setAttribute('Index',num2str(j));
        CurrentEdgesPropertiesElement.setAttribute('Color', num2str(GraphLayout.Frames{i}.EdgeProperties{j}.Color));
        CurrentEdgesPropertiesElement.setAttribute('Size', num2str(GraphLayout.Frames{i}.EdgeProperties{j}.Size));
        CurrentEdgesPropertiesElement.setAttribute('Count', num2str(numel(GraphLayout.Frames{i}.EdgeProperties{j}.Edges)/2));        
        CurrentEdgesPropertiesElement.appendChild(documentNode.createTextNode(num2str(GraphLayout.Frames{i}.EdgeProperties{j}.Edges(:).')));
    end
    
    %% algorithm
    
    AlgorithmElement = documentNode.createElement('Algorithm');  FrameElement.appendChild(AlgorithmElement);
    AlgorithmElement.setAttribute('AlgorithmName',GraphLayout.Frames{i}.Algorithm.Algorithm.AlgorithmName);
    AlgorithmElement.setAttribute('LayoutTimeOut',num2str(1000*GraphLayout.Frames{i}.Algorithm.Algorithm.LayoutTimeOut));
    AlgorithmElement.setAttribute('SettingsCount',num2str(numel(GraphLayout.Frames{i}.Algorithm.Algorithm.PropertyNames)));
    
    LabelAdjustElement = documentNode.createElement('LabelAdjust');
    AlgorithmElement.appendChild(LabelAdjustElement);
    LabelAdjustElement.setAttribute('LabelAdjustTimeOut',num2str(1000*GraphLayout.Frames{i}.Algorithm.LabelAdjustTimeOut));
    
    for j = 1 : numel(GraphLayout.Frames{i}.Algorithm.Algorithm.PropertyNames)
        AlgorithmSettingElement = documentNode.createElement('AlgorithmSetting');
        AlgorithmElement.appendChild(AlgorithmSettingElement);
        AlgorithmSettingElement.setAttribute('Name',GraphLayout.Frames{i}.Algorithm.Algorithm.PropertyNames{j});
        AlgorithmSettingElement.setAttribute('Value',num2str(GraphLayout.Frames{i}.Algorithm.Algorithm.PropertyValues{j}));
    end
    
    %% preview
    PreviewElement = documentNode.createElement('Preview');  FrameElement.appendChild(PreviewElement);
    PreviewElement.setAttribute('Count',num2str(numel(GraphLayout.Frames{i}.Preview.ParameterNames)));
    for j = 1 : numel(GraphLayout.Frames{i}.Preview.ParameterNames)
        PreviewSettingElement = documentNode.createElement('PreviewSetting');
        PreviewSettingElement.setAttribute('Name',GraphLayout.Frames{i}.Preview.ParameterNames{j});
        PreviewSettingElement.setAttribute('Value',num2str(GraphLayout.Frames{i}.Preview.ParameterValues{j}));
        PreviewElement.appendChild(PreviewSettingElement);
    end
    
end


%% export
ExportElement = documentNode.createElement('Export');  docRootNode.appendChild(ExportElement);
ExportFormatElement = documentNode.createElement('ExportFormat');  ExportElement.appendChild(ExportFormatElement);
ExportFormatElement.appendChild(documentNode.createTextNode(GraphLayout.Export.ExportFileFormat));

% thisElement = docNode.createElement('child_node');
%     thisElement.appendChild...
%         (docNode.createTextNode(sprintf('%i',i)));
%     docRootNode.appendChild(thisElement);
%
%



xmlwrite(GraphLayout.FileName,documentNode);
% documentNode.saveXML(GraphLayout.FileName)
% documentNode.write(

end % CreateLayoutXML
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DeleteFrameFiles(Folder,Name,Format)
Files= dir([Folder Name '_??????.' Format]);
for i = 1 : numel(Files)
    delete( sprintf('%s%s',Folder,Files(i).name ));
end

end % DeleteFrameFiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DefaultInput  = GetDefaultInput()
DefaultInput = {};

DefaultInput    =   FIOAddParameter(DefaultInput,'ExportFileFormat','png');
DefaultInput    =   FIOAddParameter(DefaultInput,'Directed',true);


end % GetDefaultInput()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
