
F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

% image
figure(21);
subplot(2, 2, 1);
showgrey(F);  % -
title("F")
subplot(2, 2, 2);
showgrey(G);  % |
title("G")
subplot(2, 2, 3);
showgrey(H);  % +
title("H")

% spectrum
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

figure(22);
subplot(2, 2, 1);
showgrey(log(1 + abs(Fhat)));
title("Fhat")
subplot(2, 2, 2);
showgrey(log(1 + abs(Ghat)));
title("Ghat")
subplot(2, 2, 3);
showgrey(log(1 + abs(Hhat)));
title("Hhat")
subplot(2, 2, 4);
showgrey(log(1 + abs(fftshift(Hhat))));
title("shifted Hhat")

figure(23);
showgrey(abs(fftshift(Hhat)));
title("shifted Hhat without log")

figure(24);
subplot(2, 1, 1)
hist(abs(fftshift(Hhat)))
subplot(2, 1, 2)
hist(log(1 + abs(fftshift(Hhat))))

figure(25);
subplot(2, 2, 1);
showgrey(log(1 + abs(fftshift(Fhat))));
title("shifted Fhat")
subplot(2, 2, 2);
showgrey(log(1 + abs(fftshift(Ghat))));
title("shifted Ghat")
subplot(2, 2, 3);
showgrey(log(1 + abs(fftshift(Hhat))));
title("shifted Hhat")

sum(sum(Hhat - Fhat - 2 * Ghat))  % check: zero?
