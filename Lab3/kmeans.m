function kmeans(name, K)

    if nargin < 2
        K = 8;           % number of clusters used
                         % for orange, K = 8 is best.
    end
    L = 1000;            % max number of iterations
    seed = 14;           % seed used for random initialization
    scale_factor = 1.0;  % image downscale factor
    image_sigma = 1.0;   % image preblurring scale

    I = imread(name);
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);

    tic
    [segm, ~] = kmeans_segm(I, K, L, seed);
    toc
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'kmeans1.png')
    imwrite(I,'kmeans2.png')
end

