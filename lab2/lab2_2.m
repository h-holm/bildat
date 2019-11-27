% Henrik Holm - henholm@kth.se

% Q2 ----------------------------------------
% Is it easy to find a threshold that results in thin edges?
close
clear all

% Two difference operators that approximate the first order partial
% derivatives in two orthogonal directions. Dig. Img Proc. p. 166.

% Sobel operator.
deltax = [1 2 1; 0 0 0; -1 -2 -1];
deltay = deltax';

% Img: few256.
tools = few256;

% Compute discrete derivation approximations.
dxtoolsconv = conv2(tools, deltax, 'valid');
dytoolsconv = conv2(tools, deltay, 'valid');

gradmagntools = sqrt(dxtoolsconv .^ 2 + dytoolsconv .^ 2);

thresholds = [20, 40, 60, 80, 100, 120, 140];

% First, let us plot results for few256.
figure
subplot(5,2,1);
showgrey(tools)
title('few256')

subplot(5,2,2);
hist_few = histogram(gradmagntools);
title('few256')
xlabel('Intensity')
ylabel('Count')

subplot(5,2,3);
showgrey(gradmagntools)
title('gradmagn tools')

for t = 1:length(thresholds)
    subplot(5, 2, t+3);
    showgrey((gradmagntools - thresholds(t)) > 0)
    title(sprintf('threshold: %.f', thresholds(t)))
end

% 2. Perform the same study on the image godthem256, whose content 
% include image structures of higher complexity. The work is facilitated 
% considerably if you write a Matlab procedure Lv.
godthem = godthem256;
pixels = Lv(godthem, 'valid');

figure
subplot(5,2,1);
showgrey(godthem)
title('godthem256')

subplot(5,2,2);
hist_godthem = histogram(pixels);
title('godthem256')
xlabel('Intensity')
ylabel('Count')

subplot(5,2,3);
showgrey(pixels)
title('pixels godthem')

for t = 1:length(thresholds)
    subplot(5, 2, t+3)
    showgrey((pixels - thresholds(t)) > 0)
    title(sprintf('threshold: %.f', thresholds(t)))
end

% ------------------------------------------