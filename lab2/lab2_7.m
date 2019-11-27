% Henrik Holm - henholm@kth.se

% Q7 ----------------------------------------
% Present your best results obtained with extractedge.
close
clear all

tools = few256;
house = godthem256;
images = cell(2, 1);
images{1} = tools;
images{2} = house;

% Our test values for the threshold and for the scale.
thresholds = [2, 4, 8, 10, 12];
% scales = [0.0001, 1.0, 4.0, 16.0, 64.0];
scale = 4.0;

for i = 1:length(images)
    figure
    subplot(3, 2, 1);
    showgrey(images{i})
    title('Original')
    for t = 1:length(thresholds)
        subplot(3, 2, 1+t);
        edge = extractedge(images{i}, scale, thresholds(t), 'same');
        overlaycurves(images{i}, edge)
        title(sprintf('Scale: %.f Threshold: %.f', scale, thresholds(t)))
    end
end
% ------------------------------------------