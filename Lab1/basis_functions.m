
% parameters
ps = [5, 9, 17, 17, 5, 125];
qs = [9, 5, 9, 121, 1, 1];
uc = zeros(1, 6);
vc = zeros(1, 6);
sz = 128;

% fftwave: draw figures
for i = 1:6
    figure(i);
    [uc(i), vc(i)] = fftwave(ps(i), qs(i), sz);
end

%% just demo for Q2, skip this part... important thing in next block
u = 5;
v = 9;
uc = 4;
vc = 8;
sz = 64;

Fhat = zeros(sz);
Fhat(u, v) = 1;

F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));

Fshift = fftshift(Fhat);
[M1, M2] = max(Fshift); % M2 is the row number of maximum in each cols
uc_new = max(M2);
[N1, N2] = max(M2); % N2 is the col number of 'max row numbers', find the one != 1 ...
vc_new = N2;
Fshift(uc_new-uc, vc_new-vc) = 1;
figure(7);
showgrey(Fshift);
title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))

figure(8);
realF = real(F);
realF(uc_new-uc, vc_new-vc) = 10;
realF(uc_new, vc_new) = 10;
showgrey(real(F), 64, -Fabsmax, Fabsmax);
title('real(F)')

p = 1;
q = 1;
sz = 8;
figure(9);
fftwave(p, q, sz);
p = 5;
q = 6;
sz = 8;
figure(10);
fftwave(p, q, sz);
p = 4;
q = 4;
sz = 8;
figure(11);
fftwave(p, q, sz);

%% pass the center
figure(12);
p = 65;
q = 65;
sz = 128;
fftwave(p, q, sz);
