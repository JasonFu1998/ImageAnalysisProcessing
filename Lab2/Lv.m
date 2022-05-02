function pixels = Lv(inpic, shape)
    % for Part 1-3
    
    if (nargin < 2)
        shape = 'same';
    end
    dymask = [1, 0, -1;
              2, 0, -2;
              1, 0, -1];
    dxmask = dymask';
    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    pixels = Lx.^2 + Ly.^2;
    