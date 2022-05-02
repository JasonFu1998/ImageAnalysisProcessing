function prob = mixture_prob(image, K, L, mask)
    
    image = single(image);
    [x, y, ~] = size(image);
    N_init = x * y;
%     CMAX = 255;
    
    %% Let I be a set of pixels and V be a set of 
    % K Gaussian components in 3D (R,G,B).
    I = reshape(image, [N_init, 3]);  % N_init, 3
%     Imask = reshape(mask, [N_init, 1]);
%     V = randi([0, CMAX], K, 3);
    
    %% Store all pixels for which mask=1 in a Nx3 matrix
    p_idx = mask == 1;
    pixels = I(p_idx, :);  % N, 3
    N = size(pixels, 1);
    
    %% Randomly initialize the K components using masked pixels
    % use Kmeans to estimate w and miu.
    seed = 14;
%     pixels_as_img = reshape(pixels, [N, 1, 3]);  
    [seg, u] = kmeans_segm2(image, K, L, seed);
    % seg: N, 1; u: K, 3
    
    %@ mean: u
    %@ weight
    w = zeros(1, K);
    for i = 1: K
        w(i) = mean(seg(:) == i);
    end 
    %@ covariance
    cov = cell(K, 1);
    for i = 1: K
        cov{i} = 1000 * eye(3);
    end 
    
    
    %% Iterate L times
    gau = zeros(N, K);  % col means the k-th gauss func
    for i = 1: L
        
        % Expectation: Compute probabilities P_ik using masked pixels
        for j = 1: K
            diff = bsxfun(@minus, pixels, u(j, :));  % N, 3
%             coef = 1 / sqrt( (2*pi)^3 * det(cov{j}) );
%             gau(:, j) = coef * exp(-0.5 * diag(diff / cov{j} * diff'));  % N * 1
%             gau(:, j) = coef * exp(-0.5 * diag(diff / cov{j} * diff'));
            gau(:, j) = 1 / sqrt( (2*pi)^3 * det(cov{j}) ) * exp(-0.5 * sum(((diff/cov{j}).* diff), 2));
        end
        % ?? = gau * w;  % N, 1; sum
        p_ik_num = bsxfun(@times, gau, w);    % N, K  % numerator
        p_ik = p_ik_num ./ sum(p_ik_num, 2);  % N, K
        
        % Maximization: Update weights, means and covariances using masked pixels
        
        %@ weight
        w = mean(p_ik, 1);
        
        for j = 1: K
            pk = p_ik(:, j);   % pk: N * 1; pixels: N * 3
            uk = sum(pk .* pixels, 1)/sum(pk);  % 1, 3
            %@ mean
            u(j, :) = uk;
            %@ covariance
            diff = bsxfun(@minus, pixels, u(j, :));  % N, 3
            cov{j} = diff' * (diff .* pk)/ sum(pk(:));
        end    
        
    end % endfor
    
    %% Compute probabilities p(c_i) in Eq.(3) for all pixels I.
    gau_init = zeros(N_init, K);
    for i = 1: K
%         coef = 1 / sqrt( (2*pi)^3 * det(cov{i}) );
        diff = bsxfun(@minus, I, u(i, :));  % n, 3
%         gau(i, :) = coef * exp(-0.5 * diag(diff / cov{j} * diff'));  % N,1
        gau_init(:, i) = 1 / sqrt( (2*pi)^3 * det(cov{i}) ) * exp(-0.5 * sum(((diff/cov{i}).* diff), 2));
    end
    
    p_i = sum(bsxfun(@times, gau_init, w), 2);  % N, 1
%     prob = reshape(p_i, [x, y]);    % x, y
    prob = p_i;

end
