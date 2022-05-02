
F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

%% multiply
figure(31);
subplot('121');
showgrey(F .* G);
title('F .* G');
subplot('122');
showfs(fft2(F .* G));
title('fft: F.* G');

%% conv
Fhat = fft2(F);
Ghat = fft2(G);
siz = size(Fhat);
convhat = conv2(fftshift(Fhat), fftshift(Ghat), 'same');

figure(32);
subplot('131');
showfs(Fhat);
title('Fhat');
subplot('132');
showfs(Ghat);
title('Ghat');
subplot('133');
showfs(fftshift(convhat)/siz(1)/siz(2));
title('same size: Fhat * Ghat');

%% scaling
F1 = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];

figure(33);

subplot('221');
showgrey(F .* G);
title('original');

subplot('222');
showfs(fft2(F .* G));
title('fft: original');

subplot('223');
showgrey(F1);
title('scaled');

subplot('224');
F1hat = fft2(F1);
showfs(F1hat);
title('fft: scaled');

%% rotation
alpha = 30;
G1 = rot(F1, alpha);

figure(34);

subplot('231');
showgrey(F1);
title('original image');
axis on

subplot('232');
showfs(F1hat);
title('fft(image)');
axis on

subplot('233');
showfs(fftshift(rot(fftshift(F1hat), alpha)));
title('rot(fft(image))');
axis on

subplot('234');
showgrey(G1)
title('rot(image)');
axis on

subplot('235');
Ghat1 = fft2(G1);
showfs(Ghat1);
title('fft(rot(image))');
axis on

subplot('236');
Hhat1 = rot(fftshift(Ghat1), -alpha);
% note: showfs will do fftshift, if the spec 
% has been shifted, use showgrey + log
showgrey(log(1 + abs(Hhat1)));
title('rot^{-1}(fft(rot(image)))');
axis on



