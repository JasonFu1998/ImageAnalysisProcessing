
%% Part1
tools = few256;
% kernels
% x: vertical; y: horizontal
% conv kernel rotated by 180
sim_x = [0.5; -0.5];
sim_y = [0.5, -0.5];
cen_x = [0.5; 0; -0.5];
cen_y = [0.5, 0, -0.5];
rob_x = [-1, 0; 0, 1];
rob_y = [0, -1; 1, 0];
sob_y = [1, 0, -1;
         2, 0, -2;
         1, 0, -1];
sob_x = sob_y';

% simple difference
figure;
sim_dx = conv2(tools, sim_x, 'valid');
sim_dy = conv2(tools, sim_y, 'valid');
subplot('431');
showgrey(tools);
title('original image');
subplot('432');
showgrey(sim_dx);
title('simple dx');
subplot('433');
showgrey(sim_dy);
title('simple dy');

% central difference
% figure;
cen_dx = conv2(tools, cen_x, 'valid');
cen_dy = conv2(tools, cen_y, 'valid');
subplot('434');
showgrey(tools);
title('original image');
subplot('435');
showgrey(cen_dx);
title('central dx');
subplot('436');
showgrey(cen_dy);
title('central dy');

% Robert's diagonal
% figure;
rob_dx = conv2(tools, rob_x, 'valid');
rob_dy = conv2(tools, rob_y, 'valid');
subplot('437');
showgrey(tools);
title('original image');
subplot('438');
showgrey(rob_dx);
title('robert 1');
subplot('439');
showgrey(rob_dy);
title('robert 2');

% Sobel
% figure;
sob_dx = conv2(tools, sob_x, 'valid');
sob_dy = conv2(tools, sob_y, 'valid');
subplot(4, 3, 10);
showgrey(tools);
title('original image');
subplot(4, 3, 11);
showgrey(sob_dx);
title('sobel dx');
subplot(4, 3, 12);
showgrey(sob_dy);
title('sobel dy');

% print sizes
disp('size, original:'); disp(size(tools));
disp('size, simple:'); disp(size(sim_dx));
disp('size, central:'); disp(size(cen_dx));
disp('size, robert:'); disp(size(rob_dx));
disp('size, sobel:'); disp(size(sob_dx));

%% Part2
% magnitude
sim_mag = sqrt(sim_dx(:, 1:end-1) .^2 + sim_dy(1:end-1, :) .^2);
cen_mag = sqrt(cen_dx(:, 1:end-2) .^2 + cen_dy(1:end-2, :) .^2);
rob_mag = sqrt(rob_dx(1:end-1, 1:end-1) .^2 + rob_dy(1:end-1, 1:end-1) .^2);
sob_mag = sqrt(sob_dx(1:end-2, 1:end-2) .^2 + sob_dy(1:end-2, 1:end-2) .^2);

figure;
subplot('221');
showgrey(sim_mag);
title('simple');
subplot('222');
showgrey(cen_mag);
title('central');
subplot('223');
showgrey(rob_mag);
title("Robert's");
subplot('224');
showgrey(sob_mag);
title('Sobel');

figure;
subplot('221');
histogram(sim_mag);
title('simple');
subplot('222');
histogram(cen_mag);
title('central');
subplot('223');
histogram(rob_mag);
title("Robert's");
subplot('224');
histogram(sob_mag);
title('Sobel');

sob_thresh = [20, 50, 100, 150];
figure;
subplot('221');
showgrey((sob_mag - sob_thresh(1)) > 0)
title(sprintf('thresh=%d', sob_thresh(1)));
subplot('222');
showgrey((sob_mag - sob_thresh(2)) > 0)
title(sprintf('thresh=%d', sob_thresh(2)));
subplot('223');
showgrey((sob_mag - sob_thresh(3)) > 0)
title(sprintf('thresh=%d', sob_thresh(3)));
subplot('224');
showgrey((sob_mag - sob_thresh(4)) > 0)
title(sprintf('thresh=%d', sob_thresh(4)));

img1 = godthem256;
Lv1 = Lv(img1);
thresh1 = 1e5;
thresh2 = 1e4;
figure;
subplot('221');
showgrey(img1)
subplot('222');
showgrey(Lv1);
subplot('223');
showgrey((Lv1 - thresh1) > 0);
title('thresh 1e5');
subplot('224');
showgrey((Lv1 - thresh2) > 0);
title('thresh 1e4');

% no smoothing
figure;
no_smooth = Lv(img1);
subplot('321')
% histogram(no_smooth);
showgrey(img1);
thre1 = 1e4;
subplot('322')
showgrey((no_smooth - thre1) > 0)

% 
img2 = discgaussfft(img1, 1);
smooth1 = Lv(img2);
subplot('323');
% histogram(smooth1);
showgrey(img2);
thre2 = 1e4;
subplot('324')
showgrey((smooth1 - thre2) > 0)

% 
img3 = discgaussfft(img1, 9);
smooth2 = Lv(img3);
subplot('325');
% histogram(smooth2);
showgrey(img2);
thre2 = 1e3;
subplot('326')
showgrey((smooth2 - thre2) > 0)
