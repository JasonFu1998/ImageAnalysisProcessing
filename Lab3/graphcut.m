scale_factor = 0.5;            % image downscale factor
% image region to train foreground with
% area = [ 80, 110, 570, 300 ] % tiger2 good K =5 100, 150
% area = [ 40, 90, 600, 350 ]  % tiger2 bad
K = 5;                         % number of mixture components
alpha = 100;                   % maximum edge cost
sigma = 150;                   % edge cost decay factor

% K = 5;                       % for tiger2
% alpha = 100;                 % maximum edge cost
% sigma = 150;                 % edge cost decay factor
% alpha = 100;                 % for tiger 3, k 16
% sigma = 150;  
% alpha = 100;                 % for tiger 3m k 4
% sigma = 150;  

I = imread('tiger2.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'graphcut1.png')
imwrite(I,'graphcut2.png')
imwrite(prior,'graphcut3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);

