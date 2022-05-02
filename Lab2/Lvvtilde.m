function pixels = Lvvtilde(inpic, shape)
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
    dxymask = conv2(dxmask, dymask, shape);
       
    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    Lxx = filter2(dxxmask, inpic, shape);
    Lyy = filter2(dyymask, inpic, shape);
    Lxy = filter2(dxymask, inpic, shape);
    
    pixels = Lx.^2 .* Lxx + 2 * Lx .* Ly .* Lxy + Ly.^2 .* Lyy;
    