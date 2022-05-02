
% 1. With spatial discretization and spatial convolution:
% conv2(image, discrete gauss kernal)

% 2. With spatial discretization and convolution via FFT:
% a = multiply(fft(image), fft(discrete kernel))
% ifft(a)

t = [0.1, 0.3, 1.0, 10.0, 100.0];

figure(51);
% deltafcn -> generates a discrete delta function of
% support xsize*ysize, in which the central pixel is set to one and 
% all other pixel values are set to zero.

vars = [];
for i = 1:length(t)
    subplot(2, 3, i);
    psf = gaussfft(deltafcn(128, 128), t(i));
    showgrey(psf);
    var = variance(psf);
    vars = [vars var(1, 1)];
    title(sprintf('t=%0.1f, variance=%0.5f', t(i), var(1,1)));
end

figure(52);
for i = 1:length(t)
    subplot(2, 3, i);
    gausssurf(deltafcn(128, 128), t(i));
    var = variance(psf);
    title(sprintf('t=%0.1f, variance=%0.5f', t(i), vars(i)));
end

figure(53);
img1 = phonecalc128;
img2 = few128;
img3 = nallo128;
t1 = [1.0, 4.0, 16.0, 64.0, 256.0];

subplot(6, 3, 1);
showgrey(img1);
subplot(6, 3, 2);
showgrey(img2);
subplot(6, 3, 3);
showgrey(img3);

for i = 1:length(t1)
    subplot(6, 3, 3*i+1);
    img11 = gaussfft(img1, t1(i));
    showgrey(img11);
    
    subplot(6, 3, 3*i+2);
    img21 = gaussfft(img2, t1(i));
    showgrey(img21);
    
    subplot(6, 3, 3*i+3);
    img31 = gaussfft(img3, t1(i));
    showgrey(img31);
end

% filter spectrum
figure(54);
for i = 1:length(t1)
    subplot(2, 3, i);
    kf = gaussspec(img1, t1(i));
    surf(kf);
    title(sprintf('stddev=%0.5f', t1(i)));
end
