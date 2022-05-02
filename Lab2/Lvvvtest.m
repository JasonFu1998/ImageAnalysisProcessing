function [Lxxx, Lxx, Lxxy] = Lvvvtest(shape)
    if (nargin < 1)
        shape = 'same';
    end

    % i use filter, rather than conv2.
    d = [-1/2, 0, 1/2];
    dd = [1, -2, 1];
    % x is vertical, y is horizontal
    
    dymask = [zeros(1, 5);
              zeros(1, 5);
              0, d, 0;
              zeros(1, 5);
              zeros(1, 5);
              ];
    dxmask = dymask';
          
    dyymask = [zeros(1, 5);
              zeros(1, 5);
              0, dd, 0;
              zeros(1, 5);
              zeros(1, 5);
              ];
    dxxmask = dyymask';
    
    dxxxmask = conv2(dxmask, dxxmask, shape);
    dxxymask = conv2(dxxmask, dymask, shape);
    dxyymask = conv2(dxmask, dyymask, shape);
    dyyymask = conv2(dymask, dyymask, shape);
    
    % test
    [y, x] = meshgrid(-5:5, -5:5);
    Lxxx = filter2(dxxxmask, x .^3, 'valid');    % 3!
    Lxx = filter2(dxxmask, x .^3, 'valid');    % 6x
    Lxxy = filter2(dxxymask, x .^2 .* y, 'valid'); % 2
    