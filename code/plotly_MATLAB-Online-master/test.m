%%
x = 80 * randn(1, 30);
y = 80 * randn(size(x));
r = randi(1500, size(x));
c = randi(10, size(x));

fig = figure;

scatter(x, y, r, c, 'filled', 'MarkerEdgeColor', 'k')

%--PLOTLY--%
response = fig2plotly(fig, 'filename', 'matlab-bubble-chart',  'strip', false);
plotly_url = response.url;

%% 
[X,Y,Z] = peaks;
contour(X,Y,Z,20);
fig2plotly();

%%
getplotlyoffline('https://cdn.plot.ly/plotly-latest.min.js')
X = linspace(0,2*pi,50)';
Y = [cos(X), 0.5*sin(X)];
stem(X,Y)
%fig2plotly(gcf, 'offline', true);
