function edges = extractedge(inpic, scale, threshold, shape)
% Function extractedge

% Smoothen the input image.
inpic_smoothed = discgaussfft(inpic, scale);

% Approximation of first order derivative.
Lv_first = Lv(inpic_smoothed, shape);

% Approximation of second order derivative.
Lvv_second = Lvvtilde(inpic_smoothed, shape);

% Approximation of third order derivative.
Lvvv_third = Lvvvtilde(inpic_smoothed, shape);

% Masks
mask_first = (Lv_first > threshold) - (1/2);
mask_third = (Lvvv_third < 0) - (1/2);

% Extract zero-crossing edges.
edges = zerocrosscurves(Lvv_second, mask_third);

% Subset the earlier result further by only including those points
% where the first-derivative mask value is non-negative. 
edges = thresholdcurves(edges, mask_first);

end
