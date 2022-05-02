function mean_shift(name, bws, bwc)

    scale_factor = 0.5;            % image downscale factor
    if nargin < 2
        spatial_bandwidth = 10.0;  % spatial bandwidth
    else
        spatial_bandwidth = bws;
    end
    if nargin < 3
        colour_bandwidth = 5.0;    % colour bandwidth
    else
        colour_bandwidth = bwc;
    end
    num_iterations = 40;           % number of mean-shift iterations
    image_sigma = 1.0;             % image preblurring scale

    I = imread(name);
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);

    segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'meanshift1.png')
    imwrite(I,'meanshift2.png')
    subplot(1,2,1); imshow(Inew);
    subplot(1,2,2); imshow(I);

end