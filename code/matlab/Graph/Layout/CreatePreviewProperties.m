function PreviewProperties = CreatePreviewProperties( ParameterNames, ParameterValues)
% Set preview settings. See gephi: PreviewProperty enum
%
% Receives:
%   ParameterNames - cell array of parameter names
%   ParameterValues - cell array of parameter values
%
%
%
% See Also:
%   GraphLoad, GraphLayoutAddFrame, GraphLayoutDraw
%
%
% Algorithm:
%   See Gephi toolkit for possible values: http://gephi.org/docs/api/org/gephi/preview/api/PreviewProperty.html
% List of properties:
%{
        PropertiesBoolean : 
        DIRECTED
        EDGE_CURVED
        EDGE_LABEL_SHORTEN
        EDGE_RESCALE_WEIGHT
        MOVING
        NODE_LABEL_PROPORTIONAL_SIZE
        NODE_LABEL_SHORTEN
        SHOW_EDGE_LABELS
        SHOW_EDGES
        SHOW_NODE_LABELS

        Float
        ARROW_SIZE
        EDGE_LABEL_OUTLINE_OPACITY
        EDGE_LABEL_OUTLINE_SIZE
        EDGE_OPACITY
        EDGE_RADIUS
        EDGE_THICKNESS
        MARGIN
        NODE_BORDER_WIDTH
        NODE_LABEL_OUTLINE_OPACITY
        NODE_LABEL_OUTLINE_SIZE
        NODE_OPACITY
        VISIBILITY_RATIO                

        Color
        
        BACKGROUND_COLOR

        UnsupportedProperties        
        EDGE_COLOR
        EDGE_LABEL_COLOR
        EDGE_LABEL_OUTLINE_COLOR
        EDGE_LABEL_OUTLINE_COLOR
        NODE_BORDER_COLOR
        NODE_LABEL_COLOR
        NODE_LABEL_OUTLINE_COLOR
        EDGE_LABEL_FONT
        NODE_LABEL_FONT
        NODE_LABEL_BOX_COLOR
        NODE_LABEL_BOX_OPACITY
        NODE_LABEL_SHOW_BOX
        CATEGORY_EDGE_ARROWS
        CATEGORY_EDGE_LABELS
        CATEGORY_EDGES
        CATEGORY_NODE_LABELS
        CATEGORY_NODES             
    
        Integers
        EDGE_LABEL_MAX_CHAR                
        NODE_LABEL_MAX_CHAR


%}
%
%{
GraphLayout = GraphLayoutPreview(GraphLayout, ...
        {'SHOW_NODE_LABELS','EDGE_CURVED','NODE_LABEL_PROPORTIONAL_SIZE'}, ...
        {true, false,false} ...
  ); 
%}

%% test input  + defaults
error(nargchk(2,2,nargin));
error(nargoutchk(0,1,nargout));

if numel(ParameterNames)~=numel(ParameterValues), error('incompatible cell array sizes'); end
%% initialize
PreviewProperties.ParameterNames =  ParameterNames;
PreviewProperties.ParameterValues =  ParameterValues;

end % InitializeGraphLayout



