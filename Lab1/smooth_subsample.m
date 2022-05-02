
%% Gaussian
img = phonecalc256;
smoothimg = img;
% img: only subsample
% smoothimg: first subsample, then smooth
N=5;

figure(71);
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = gaussfft(smoothimg, 0.5);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
end

%% ideal
img = phonecalc256;
smoothimg = img;
% img: only subsample
% smoothimg: first subsample, then smooth
N=5;

figure(72);
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = ideal(smoothimg, 0.3);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
end
