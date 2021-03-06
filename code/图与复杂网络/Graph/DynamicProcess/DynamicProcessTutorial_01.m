% DynamicProcessTutorial_01

%% create square lattice s
m = 200; % lattice dimentions
n = 200;
PInitialInfection = 3/40000; %the  probability of infection at start. On average we'll start with 3 nodes
PSpontaneousInfection = 0; % the probability of spontaneous infection (not due to contagion) as the simulation runs. 
PTransfer = 5/100; % the probability of infection transfer per link per unit time. 
Graph = GraphGenerateSquareLattice(m,n); % create regular graph
Degrees = GraphCountNodesDegree(Graph); % compute degrees. 
DP_SI = DynamicProcessInitializeSI(Graph,[],PInitialInfection,PSpontaneousInfection,PTransfer); % initialize SI for the lattice. 
    % Second parameter ([]) instructs the framework to extract node IDs from the Graph (i.e. no isolates). 
    % third parameter - probability of infection at start. On average we'll start with 3 nodes 
    % next - the probability of spontaneous infection (not due to contagion). as the simulation runs. 
    % last parameter - the probability of infection transfer per link per unit time. 
while nnz(DP_SI.States)==0 
    % ensure that at least one node is infected at startup. Otherwise, infection will not start (spontan adoption,PSpontaneousInfection, is set to zero). 
    DP_SI = DynamicProcessInitializeSI(Graph,[],PInitialInfection0,PSpontaneousInfection,PTransfer);
end
figure;
h1 = subplot(2,1,1);   % top panel is going to show the total number of infected nodes
h2 = subplot(2,2,3);   % bottom-left panel showing the number of nodes infected at each time step
h3 = subplot(2,2,4);   % shos the average degree of the newly infected nodes. 
AverageDegree = mean(Degrees(DP_SI.UserData.TimeLine==DP_SI.Time,3)); % compute the average degree of the initially infected nodes. 
while any(DP_SI.States~=true) % continue the simulatiion as long as there's at least one node 
    DP_SI = DynamicProcessIterate(DP_SI,1); % perform 1 simulation step
    % plot the results
    [NumberOfInfected, TimeAxis]= hist(double(DP_SI.UserData.TimeLine(DP_SI.UserData.TimeLine~=-1)),0: DP_SI.Time); % compute the number of infected at each time step. 
    subplot(h1); plot(TimeAxis, cumsum(NumberOfInfected),'*:b'); xlabel('Time'); ylabel('Cumulative number of infected'); title(sprintf('time=%d',DP_SI.Time)); % plot cumulated infected 
    subplot(h2); plot(TimeAxis, NumberOfInfected,'*:r'); xlabel('Time'); ylabel('Number of infected');      % plot the number of infected per time step over time
    if any(DP_SI.UserData.TimeLine==DP_SI.Time) % compute and plot the average degree of the recently infected node. 
        AverageDegree(end+1) = mean(Degrees(DP_SI.UserData.TimeLine==DP_SI.Time,3));
    else
        AverageDegree(end+1) = NaN; %average degree doesn't exist if there are no new infected nodes. 
    end
    subplot(h3); plot(TimeAxis, AverageDegree,'*:r'); xlabel('Time'); ylabel('Average degree'); 
    drawnow % update the plot
end 
%% generate the diffusion video   
AviObj = VideoWriter('SI.avi');
AviObj.FrameRate = 10;
AviObj.Quality = 100;
open(AviObj);
figure;
FreshnessRange = 15; % nodes infected within this interval of time are still considered "fresh" and colored as such
    for i =0 : double(max(DP_SI.UserData.TimeLine))+FreshnessRange
    Map = zeros(m,n); 
    Map(DP_SI.UserData.TimeLine~=-1 & DP_SI.UserData.TimeLine<(i-FreshnessRange+1)) = 1;
    Map(DP_SI.UserData.TimeLine~=-1 & DP_SI.UserData.TimeLine<=i & DP_SI.UserData.TimeLine>=i-FreshnessRange+1) = 2;
    Map(Map==0) = NaN;
    Map(1,1) = 2;
    pcolor(1:n, 1:m, Map); 
    title(sprintf('T=%2.2d',i));
    shading interp
    drawnow   
    CurrentFrame = getframe;
writeVideo(AviObj,CurrentFrame);
end
close(AviObj);

%% SI on Scale-free network
Graph = mexGraphCreateRandomGraph(m*n,[1 : 200],[1 : 200].^-2.35); % create a graph of m*n nodes with power law distribution of degrees. 
    % The average degree of that graph is approximately 4, same as square lattice. 
Graph  = GraphMakeUndirected(Graph ); % make the graph undirected.
% the following code is identical to the Lattice case. 
Degrees = GraphCountNodesDegree(Graph); % compute node degrees. 
DP_SI = DynamicProcessInitializeSI(Graph,[],PInitialInfection,PSpontaneousInfection,PTransfer);
while nnz(DP_SI.States)==0
    DP_SI = DynamicProcessInitializeSI(Graph,[],PInitialInfection,PSpontaneousInfection,PTransfer);
end
figure;
h1 = subplot(2,1,1);   
h2 = subplot(2,2,3);   
h3 = subplot(2,2,4);   
AverageDegree = mean(Degrees(DP_SI.UserData.TimeLine==DP_SI.Time,3));
while any(DP_SI.States~=true)
    DP_SI = DynamicProcessIterate(DP_SI,1);
    [NumberOfInfected, TimeAxis]= hist(double(DP_SI.UserData.TimeLine(DP_SI.UserData.TimeLine~=-1)),0: DP_SI.Time);
    subplot(h1); plot(TimeAxis, cumsum(NumberOfInfected),'*:b'); xlabel('Time'); ylabel('Cumulative number of infected'); title(sprintf('time=%d',DP_SI.Time));
    subplot(h2); plot(TimeAxis, NumberOfInfected,'*:r'); xlabel('Time'); ylabel('Number of infected');     
    if any(DP_SI.UserData.TimeLine==DP_SI.Time)
        AverageDegree(end+1) = mean(Degrees(DP_SI.UserData.TimeLine==DP_SI.Time,3));
    else
        AverageDegree(end+1) = NaN;
    end
    subplot(h3); plot(TimeAxis, AverageDegree,'*g');hold on; plot(TimeAxis, ones(size(TimeAxis))*mean(Degrees(:,3)),'g-','LineWidth',4); hold off; xlabel('Time'); ylabel('Average degree'); 
    drawnow
end