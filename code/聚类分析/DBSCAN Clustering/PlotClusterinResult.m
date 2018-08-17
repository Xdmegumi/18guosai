%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML110
% Project Title: Implementation of DBSCAN Clustering in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function PlotClusterinResult(X, IDX)

    k=max(IDX);

    Colors=[0.96,0.55,0.53;0.49,0.67,0.98];
    S = {'s','o'};
    Legends = {};
    for i=0:k
        Xi=X(IDX==i,:);
        if i~=0
            Style = S{i};
            MarkerSize = 7;
            LineWidth = 1.2;
            Color = Colors(i,:);
            Legends{end+1} = ['Cluster #' num2str(i)];
        else
            Style = 'x';
            MarkerSize = 9;
            LineWidth = 2;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
            end
        end
        if ~isempty(Xi)
            plot(Xi(:,1),Xi(:,2),Style,'Color',Color,'MarkerSize',MarkerSize,'LineWidth',LineWidth);
        end
        hold on;
    end
    hold off;
    axis equal;
    grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');

end