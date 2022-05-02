function pixels = Lvvvtilde(inpic, shape)
    if (nargin < 2)
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
       
    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    Lxxx = filter2(dxxxmask, inpic, shape);
    Lxxy = filter2(dxxymask, inpic, shape);
    Lxyy = filter2(dxyymask, inpic, shape);
    Lyyy = filter2(dyyymask, inpic, shape);
    
    pixels = Lx.^3 .* Lxxx + 3 * Lx.^2 .* Ly .* Lxxy + ...
        3 * Lx .* Ly.^2 .* Lxyy + Ly.^3 .* Lyyy;
    