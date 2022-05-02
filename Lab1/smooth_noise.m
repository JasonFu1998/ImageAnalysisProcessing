
%% import
office = office256;
add = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

%% small demo
figure(61);
subplot('131');
showgrey(office);
title('original');
subplot('132');
showgrey(add);
title('gauss');
subplot('133');
showgrey(sap);
title('salt and pepper');

%% deal with gaussian noise
figure(62);

% gauss
stddev = [1e-1, 1e0, 5e0, 1e1];
subplot('341')
showgrey(discgaussfft(add, stddev(1)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(1)));
subplot('342')
showgrey(discgaussfft(add, stddev(2)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(2)));
subplot('343')
showgrey(discgaussfft(add, stddev(3)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(3)));
subplot('344')
showgrey(discgaussfft(add, stddev(4)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(4)));

% median
window = [2, 4, 6, 8];
subplot('345')
showgrey(medfilt(add, window(1)));
title(sprintf('median filter, window size=%d', window(1)));
subplot('346')
showgrey(medfilt(add, window(2)));
title(sprintf('median filter, window size=%d', window(2)));
subplot('347')
showgrey(medfilt(add, window(3)));
title(sprintf('median filter, window size=%d', window(3)));
subplot('348')
showgrey(medfilt(add, window(4)));
title(sprintf('median filter, window size=%d', window(4)));

% ideal lowpass
cutoff = [1e-2, 1e-1, 2e-1, 4e-1];
subplot(3, 4, 9)
showgrey(ideal(add, cutoff(1)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(1)));
subplot(3, 4, 10)
showgrey(ideal(add, cutoff(2)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(2)));
subplot(3, 4, 11)
showgrey(ideal(add, cutoff(3)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(3)));
subplot(3, 4, 12)
showgrey(ideal(add, cutoff(3)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(4)));

%% deal with sap noise
figure(63);

% gauss
stddev = [1e-1, 1e0, 5e0, 1e1];
subplot('341')
showgrey(discgaussfft(sap, stddev(1)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(1)));
subplot('342')
showgrey(discgaussfft(sap, stddev(2)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(2)));
subplot('343')
showgrey(discgaussfft(sap, stddev(3)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(3)));
subplot('344')
showgrey(discgaussfft(sap, stddev(4)));
title(sprintf('gauss filter, stddev=%0.2f', stddev(4)));

% median
window = [2, 4, 6, 8];
subplot('345')
showgrey(medfilt(sap, window(1)));
title(sprintf('median filter, window size=%d', window(1)));
subplot('346')
showgrey(medfilt(sap, window(2)));
title(sprintf('median filter, window size=%d', window(2)));
subplot('347')
showgrey(medfilt(sap, window(3)));
title(sprintf('median filter, window size=%d', window(3)));
subplot('348')
showgrey(medfilt(sap, window(4)));
title(sprintf('median filter, window size=%d', window(4)));

% ideal lowpass
cutoff = [1e-2, 1e-1, 2e-1, 4e-1];
subplot(3, 4, 9)
showgrey(ideal(sap, cutoff(1)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(1)));
subplot(3, 4, 10)
showgrey(ideal(sap, cutoff(2)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(2)));
subplot(3, 4, 11)
showgrey(ideal(sap, cutoff(3)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(3)));
subplot(3, 4, 12)
showgrey(ideal(sap, cutoff(3)));
title(sprintf('lowpass filter, cut off freq=%0.2f', cutoff(4)));
