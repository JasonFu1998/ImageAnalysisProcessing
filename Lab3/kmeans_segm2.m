function [segmentation,centers] = kmeans_segm2(image, K, L, seed)
    
    % param
    threshold = 0.01;
    
    rng(seed);
    I = image;
    [x, y, ~] = size(I);
    n = x * y;
    I = double(reshape(I, n, 3));
    CMAX = 255;
    
    % init
    centers = CMAX * rand(K,3);
    segmentation = zeros(n, 1);
    min_center = zeros(n, 1);
    old_centers = zeros(size(centers));
    
    V = zeros(K, 4);   % row1 : num of pxl, then 3 rows: rgb
    
    for i = 1: L
        Dist = pdist2(centers,I);
        [~, min_center] = min(Dist);

        for j = 1: K
            V(j,1) = sum(min_center(:)==j);
            idx = find(min_center == j);
            
            if isempty(idx)
                centers(j,:) = CMAX * rand(1,3);
            else
                V(j, 2) = sum(I(idx, 1))/V(j, 1);
                V(j, 3) = sum(I(idx, 2))/V(j, 1);
                V(j, 4) = sum(I(idx, 3))/V(j, 1);
                centers(j, :) = V(j, 2:4);
            end

        end
           
        % check converge
        if ~ any((abs(centers - old_centers) > threshold))
            break;
        else
            old_centers = centers;
        end

    end

    for j = 1: K
         idx = min_center == j;
         segmentation(idx, 1) = j;
    end
    
    segmentation = reshape(segmentation, x, y);

end