function Khat = gaussspec(pic, t)
  % return the spectrum of gauss filter

  [sx, sy] = size(pic);
  
  % get meshgrid
  x = -sx/2:sx/2-1;
  y = -sy/2:sy/2-1;
  [X, Y] = meshgrid(x, y);
  K = 1/(2*pi*t) * exp(-(X.^2+Y.^2)/2/t);

  Khat = abs(fftshift(fft2(K)));