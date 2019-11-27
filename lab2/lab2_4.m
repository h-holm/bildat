% Henrik Holm - henholm@kth.se

% Q4 ----------------------------------------
% What can you observe?
close
clear all

house = godthem256;

% Create a vector containing the sigma values (scales) we are interested
% in.
scales = [0.0001, 1, 4, 16, 64];

figure
subplot(3, 2, 1)
showgrey(house)
title('Original')
for s = 1:length(scales)
    subplot(3, 2, 1+s);
    contour(Lvvtilde(discgaussfft(house, scales(s)), 'same'), [0,0])
    axis('image')
    axis('ij')
    title(sprintf('Scale: %.4f', scales(s)))
end
% ------------------------------------------