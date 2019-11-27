function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)

curves = extractedge(pic, scale, gradmagnthreshold, 'same');
magnitude = Lv(pic, 'same');

[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);

if verbose == 1
    figure
    subplot(1, 2, 1)
    overlaycurves(pic, linepar);
    axis([1 size(pic, 2) 1 size(pic, 1)]);                        
    title('Original input image')
    subplot(1, 2, 2)
    showgrey(binsepsmoothiter(acc, 0.5, 1))
    title('Smoothened Hough transform')
end

