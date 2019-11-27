% Henrik Holm - henholm@kth.se

% Q5 ----------------------------------------
% Which are your observations and conclusions?
close
clear all

tools = few256;

% Create a vector containing the sigma values (scales) we are interested
% in.
scales = [0.0001, 1.0, 4.0, 16.0, 64.0];

figure
subplot(3, 2, 1)
showgrey(tools)
title('Original')
for s = 1:length(scales)
    subplot(3, 2, 1+s);
    % contour(Lvvvtilde(discgaussfft(tools, scales(s)), 'same') < 0)
    showgrey(Lvvvtilde(discgaussfft(tools, scales(s)), 'same') < 0)
    axis('image')
    axis('ij')
    title(sprintf('Scale: %.4f', scales(s)))
end
% ------------------------------------------