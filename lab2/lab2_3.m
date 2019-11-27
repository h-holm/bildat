% Henrik Holm - henholm@kth.se

% Q3 ----------------------------------------
% Does smoothing help in finding edges?
close
clear all

godthem = godthem256;

% First, smooth/blur using a Gaussian.
sigma = 5;
godthem_smoothed = discgaussfft(godthem, sigma);
pixels = Lv(godthem, 'valid');
pixels_smoothed = Lv(godthem_smoothed, 'valid');

% Second, perform edge detection on the result.
thresholds = [2, 4, 6, 8, 12, 16, 24, 32, 40];

% Original image.
figure
subplot(5, 2, 1);
showgrey(godthem)
title('Original')
for t = 1:length(thresholds)
    subplot(5, 2, t+1);
    showgrey((pixels - thresholds(t)) > 0)
    title(sprintf('threshold: %.f', thresholds(t)))
end

% Smoothed image.
figure
subplot(5, 2, 1);
showgrey(godthem_smoothed)
title('Smoothed')
for t = 1:length(thresholds)
    subplot(5, 2, t+1)
    showgrey((pixels_smoothed - thresholds(t)) > 0)
    title(sprintf('threshold: %.f', thresholds(t)))
end

% ------------------------------------------