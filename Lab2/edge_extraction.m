
house = godthem256;
tools = few256;

%% tools
scales = [0.0001, 1.0, 4.0, 16.0, 64.0];
% 16 or 64: edge inaccurate
% best: 300, 80, 20, x, x
thresh = [20, 25, 30, 40];
figure;
edges = extractedge(tools, scales(3), thresh(1));
overlaycurves(tools, edges);
title(sprintf('scales = %0.4f, threshold = %d', scales(3), thresh(1)));

%% house
scales = [0.0001, 1.0, 4.0, 16.0, 64.0];
% x, 50, , x, x
thresh = [6, 8];
edges = extractedge(house, scales(3), thresh(2));
overlaycurves(house, edges);
title(sprintf('scales = %0.4f, threshold = %d', scales(3), thresh(2)));
