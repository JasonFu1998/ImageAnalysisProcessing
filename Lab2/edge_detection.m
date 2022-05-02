
%% demo
[L1, L2, L3] = Lvvvtest();

%% experiment1
house = godthem256;
scales = [1e-4, 1, 4, 16, 64];
for i = 1:length(scales)
    subplot(2, 3, i);
    % contour(peaks,[3 3]) draws the contour line at where peaks == 3
    contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0]);
    axis('image');
    axis('ij');
    title(sprintf('stddev=%d', scales(i)));
end

%% experiment2
tools = few256;
for i = 1:length(scales)
    subplot(2, 3, i);
    showgrey(Lvvvtilde(discgaussfft(tools, scales(i)), 'same') < 0)
%     axis('image');
%     axis('ij');
    title(sprintf('stddev=%d', scales(i)));
end

% %% experiment3
% for i = 1:length(scales)
%     subplot(2, 3, i);
% %     lvv = round(Lvvtilde(discgaussfft(house, scales(i)))) == 0;
%     lvv = Lvvtilde(discgaussfft(house, scales(i)));
%     lvvv = Lvvvtilde(discgaussfft(house, scales(i)), 'same') < 0;
%     contour(lvv + 1e5 *lvvv, [0 0]);
%     axis('image');
%     axis('ij');
%     title(sprintf('stddev=%d', scales(i)));
% end