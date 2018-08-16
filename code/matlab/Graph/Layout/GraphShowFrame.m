function AxisHandle = GraphShowFrame(GraphLayout, FrameIndex, FigureHandle)
% Initialized graph layout - a structure containing instructions for plotting the graph
%
% Receives:
%   GraphLayout - structure - The Graph Layout structure after it had been returned from GraphLayoutDraw
%   FrameIndex  -  integer - index of the frame to plot. 
%   FigureHandle - handle  - (optional) points to the figure where the graph will be drawn. Default: [] (a new figure will be created). 
%                                           
% Returns: 
%   AxisHandle - handle - handle of the axis on which the network is plotted. 
%
% See Also:
%   GraphLayoutDraw, GraphLayoutAddFrame, GraphLayoutDraw
%
%

%% test input  + defaults
error(nargchk(2,3,nargin));
error(nargoutchk(0,1,nargout));

if ~isfield(GraphLayout, 'FrameFileNames'), error('Graphs do not yet exist. Run GraphLayoutDraw'); end
if numel(GraphLayout.FrameFileNames)<FrameIndex, error('FrameIndex (%d) exceeds number of frames (%d)',FrameIndex, numel(GraphLayout.FrameFileNames)); end
if FrameIndex<=0, error('FrameIndex (%d) must be positive', FrameIndex); end 
if ~exist(GraphLayout.FrameFileNames{FrameIndex},'file'), error('Can''t fine frame image file ''%s''',GraphLayout.FrameFileNames{FrameIndex}); end 

if ~exist('FigureHandle','var') || isempty(FigureHandle) || ~ishandle(FigureHandle), FigureHandle = figure; end
switch get(FigureHandle,'Type')
    case 'figure'
        figure(FigureHandle); 
    case 'axes'
        axis(FigureHandle); 
    otherwise 
        error('Unsupported handle type: %s',get(FigureHandle,'Type')); 
end
Image = imread(  GraphLayout.FrameFileNames{FrameIndex} );
WarningState = warning('off','images:initSize:adjustingMag');
imshow(Image);
warning(WarningState.state,WarningState.identifier);
AxisHandle  = gca;