function [linepar, acc] = houghedgeline(pic, scale, ...
    gradmagnthreshold, nrho, ntheta, nlines, verbose)

% ==== Output ====
%  linepar            ..... a list of (ρ; θ) parameters for each line segment,
%  acc                ..... the accumulator matrix of the Hough transform,
% ==== Input =====
%  pic                ..... the grey-level image
%  scale              ..... the scale at which edges are detected
%  gradmagnthreshold  ..... the threshold of the gradient magnitude
% ================

    edgecurves = extractedge(pic, scale, gradmagnthreshold);
    [linepar, acc] = houghline(edgecurves, pic, nrho, ...
        ntheta, gradmagnthreshold, nlines, verbose);
    
    outcurves = zeros(2, nlines * 4); % 1 info, 3 points for each line.
    for idx = 1: size(linepar, 2)
        % rho, theta -> x, y
        rho = linepar(1, idx);
        theta = linepar(2, idx);
        % must go thru: rho cos, rho sin
        % direction? (sin, -cos)
        x0 = rho * cos(theta);
        y0 = rho * sin(theta);
        dx = 1e4 * sin(theta);
        dy = 1e4 * -cos(theta);
    
        outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
        outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
        outcurves(2, 4*(idx-1) + 2) = x0-dx;
        outcurves(1, 4*(idx-1) + 2) = y0-dy;
        outcurves(2, 4*(idx-1) + 3) = x0;
        outcurves(1, 4*(idx-1) + 3) = y0;
        outcurves(2, 4*(idx-1) + 4) = x0+dx;
        outcurves(1, 4*(idx-1) + 4) = y0+dy;
    end
    
    % Overlay these curves on the gradient magnitude image
    overlaycurves(pic, outcurves);
    [sx, sy] = size(pic);
    xlim([1 sx]);
    ylim([1 sy]);
    % Return the output data
