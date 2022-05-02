function edgecurves = extractedge(inpic, scale, threshold, shape)
    
    if (nargin < 4)
        shape = 'same';
    end
    
    % Gaussian
    gpic = discgaussfft(inpic, scale);
    
    % difference 
    lv = Lv_new(gpic, shape);
    lvv = Lvvtilde(gpic, shape);
    lvvv_mask = (Lvvvtilde(gpic, shape) < 0) - 0.5;
    
    % edges
    % NOTE: These funcs check if masks are NON-NEGATIVE !!!
    % minus 0.5
    curves = zerocrosscurves(lvv, lvvv_mask);
    
    if (nargin < 3)   % no threshold
        lv_mask = ones(size(lv));
    else
        lv_mask = (lv > threshold) - 0.5;
    end
    
    edgecurves = thresholdcurves(curves, lv_mask);
    
    % test
%     overlaycurves(tools, edgecurves);
