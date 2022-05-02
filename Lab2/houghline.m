function [linepar, acc] = houghline(curves, magnitude, nrho, ...
    ntheta, threshold, nlines, verbose)

% ==== Output ====
%  linepar    ..... a list of (ρ; θ) parameters for each line segment,
%  acc        ..... the accumulator matrix of the Hough transform,
% ==== Input =====
%  curves     ..... the polygons from which the transform is to be computed,
%  magnitude  ..... an image with one intensity value per pixel
%    (in exercise 6.2 you will here give the gradient magnitude as an argument),
%  nrho       ..... the number of accumulators in the ρ direction,
%  ntheta     ..... the number of accumulators in the θ direction,
%  threshold  ..... the lowest value allowed for the given magnitude,
%  nlines     ..... the number of lines to be extracted,
%  verbose    ..... the degree of extra information and figures that will be shown.
%    verbose = 1: blur the accumulators
%    verbose = 2 or 3, incrementation functions
% ================

    % Check if input appear to be valid
    if nargin < 6
        disp('Error: Too few arguments!');
        return
    end
    if nargin < 7
        verbose = 0;
    end
        
    % Allocate accumulator space
    acc = zeros(nrho, ntheta);
    
    % Define a coordinate system in the accumulator space
    % NOTE: if rho is always positive, theta should be (-pi, pi)
    [xmax, ymax] = size(magnitude);
    D = hypot(xmax, ymax);
    rhos = linspace(-D, D, nrho);    % list of rho and theta
    thetas = linspace(-pi/2, pi/2, ntheta);

% ==== This part is based on function pixelplotcurves ====

    insize = size(curves, 2);
    trypointer = 1;
    numcurves = 0;
    % Loop over all the input curves
    while trypointer <= insize
        polylength = curves(2, trypointer);
        numcurves = numcurves + 1;
        trypointer = trypointer + 1;
        % For each point on each curve
        for polyidx = 1:polylength
            x = curves(2, trypointer);
            y = curves(1, trypointer);
            % (Optionally, keep value from magnitude image)
            mag = magnitude(round(x), round(y));
            
            % Check if valid point with respect to threshold
            if mag >= threshold    % else abandon this point

                % Loop over a set of theta values
                for itheta = 1: ntheta
                    theta = thetas(itheta);
                    % Compute rho for each theta value
                    rho = x * cos(theta) + y * sin(theta);
                    % Compute index values in the accumulator space
                    % rho ~(-D, D) -> (rho + D)/2D ~(0, 1) 
                    % -> nrho * ... ~(0, nrho) 
                    irho = ceil(nrho * (rho + D)/(2*D));
                    % Update the accumulator
                    % Note: Increment function: y=logx, y=x
                    if verbose == 0 || verbose == 1
                        acc(irho, itheta) = acc(irho, itheta) + 1;
                    elseif verbose == 2
                        acc(irho, itheta) = acc(irho, itheta) + log(mag);
                    elseif verbose == 3
                        acc(irho, itheta) = acc(irho, itheta) + mag^1.5;
                    end
                        
                end % endfor theta
            end % endif threshold
            trypointer = trypointer + 1;
        end % endfor points
    end % endwhile curves

% =========================
    
    % Extract local maxima from the accumulator
    % Note: blur the accumulators
    if verbose == 1
        acc = binsepsmoothiter(acc, 0.3, 1);
    end
    
    [pos, value] = locmax8(acc); % pos and val for the local maximums
    [~, indexvector] = sort(value); % ignore value, just ascending indices
    nmaxima = size(value, 1); % how many we find
    
    % Delimit the number of responses if necessary
    if nmaxima < nlines
        nlines = nmaxima;
    end
    linepar = zeros(2, nlines);
    
    % Compute a line for each one of the strongest responses in the accumulator
    for idx = 1: nlines
        % fetch positions(rho, theta) with largest values
        rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
        thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
        % compute value(rho, theta)
        rho = rhos(rhoidxacc);
        theta = thetas(thetaidxacc);
        linepar(:, idx) = [rho; theta];
    end
    