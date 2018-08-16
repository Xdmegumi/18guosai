function GraphLayout = GraphLayoutMovie(GraphLayout,FrameRate)
% Generates movie (in avi format ) merging the sequence of frames. 
%
% Receives:
%   GraphLayout - structure - The Graph Layout structure after it had been returned from GraphLayoutDraw
%   FrameRate - double - (optional)number of frames per second. default: 10. 
%
% Returns: 
%    GraphLayout - structure - The Graph Layout structure, with the field GraphLayout.VideoFileName containing the name of the avi file.                                 
%
%
% See Also:
%   GraphLayoutDraw,GraphShowFrame, GraphLayoutAddFrame, GraphLayoutDraw
%
%

%% test input  + defaults
error(nargchk(1,2,nargin));
error(nargoutchk(0,1,nargout));
if ~exist('FrameRate','var'), FrameRate = 10; end   

if GraphLayout.Execution.ExitStatus~=0
     error('Failed building graph. ExitStatus: %d, \n message:\n\t%s\nCommand Line:\n\t%s',GraphLayout.Execution.ExitStatus, GraphLayout.Execution.result,GraphLayout.Execution.CommandLine);
end
if ~exist('FrameRate','var'), FrameRate = 3; end
GraphLayout.VideoFileName = [GraphLayout.Parameters.TempFolder GraphLayout.GraphName '.avi'];
writerObj = VideoWriter(GraphLayout.VideoFileName );
writerObj.FrameRate = FrameRate;
open(writerObj);
FigureHandle = figure;
for i = 1: numel(GraphLayout.FrameFileNames)
    GraphShowFrame(GraphLayout, i, FigureHandle);
    frame = getframe;
    writeVideo(writerObj,frame);
    %     set(gca,'nextplot','replacechildren');
    % set(gcf,'Renderer','zbuffer');
    
end
close(writerObj);
