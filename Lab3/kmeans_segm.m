function [segmentation, centers] = kmeans_segm(image, K, L, seed)

    % prepare...
    rng(seed);
    image = double(image);
    [x, y, ~] = size(image);
    n = x * y;
 
    % let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
    X = reshape(image, [n, 3]);
    % disp(min(X, [],1));

    % randomly initialize the K cluster centers
%     V = [0, 0, 0;
%         255, 255, 255;
%         randi([0, 255], K-2, 3)
%         ];
    V = randi([0, 255], K, 3);
    
    % compute all distances between pixels and cluster centers
    dis = pdist2(X, V);  % size: numX, numV; rows: V, cols: X
    
    % check: if V changed ?
    midx_old = ones(n, 1) * (-1);  
    idx_thresh = 1e-4;   % how many pixels changed its center?
    
    % iterate L times if not converged
    for i = 1: L
        % assign each pixel to the cluster center 
        % for which the distance is minimum
        [~, midx] = min(dis, [], 2);
        
        % check convergence
        if mean(midx_old ~= midx) < idx_thresh
            break;
        else
            midx_old = midx;
        end
        
        % recompute each cluster center by taking 
        % the mean of all pixels assigned to it
        for j = 1: K
            pixels = find(midx == j);
            V(j, :) = mean(X(pixels, :), 1);   % r, g, b
        end
        
        % recompute all distances between pixels and cluster centers
        dis = pdist2(X, V);  
    end 
    
    % return...
    segmentation = reshape(midx, x, y);
    centers = V;
    
    fprintf("final L value: %d\n", i-1);
end
