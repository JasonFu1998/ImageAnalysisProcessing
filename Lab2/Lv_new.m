function pixels = Lv_new(inpic, shape)
    % for Part 4-6
    
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
    
    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);

    pixels = Lx.^2 + Ly.^2;

    