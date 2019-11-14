% Henrik Holm, 2019-11-12

% 3.1 -------------------------------------
close
clear all

office = office256;

% Gaussian noise.
add = gaussnoise(office, 16);
% Salt and pepper noise (grains/spots).
sap = sapnoise(office, 0.1, 255);


%----- 1. Gaussian smoothing --------------
figure
subplot(5, 2, 1);
showgrey(add)
title('add');
subplot(5, 2, 2);
showgrey(sap)
title('sap');
t_values = [0.3, 1.0, 10.0, 100.0];
% 1.1 Gaussian noise
for i = 1 : length(t_values)
    t = t_values(i);
    subplot(5,2,(i*2)+1)
    psf = gaussfft(add, t);
    showgrey(psf)
    title(sprintf('add t = %0.2f', t))
end

% 1.2 Salt and pepper noise
for i = 1 : length(t_values)
    t = t_values(i);
    subplot(5,2,(i*2)+2)
    psf = gaussfft(sap, t);
    showgrey(psf)
    title(sprintf('sap t = %0.2f', t))
end
%------------------------------------------


%------ 2. Median filtering ---------------
figure()
subplot(5, 2, 1);
showgrey(add)
title('add');
subplot(5, 2, 2);
showgrey(sap)
title('sap');
w_widths = [2, 4, 8, 16];
% 2.1 Gaussian noise
for i = 1 : length(w_widths)
    w_width = w_widths(i);
    subplot(5,2,(i*2)+1)
    psf = medfilt(add, w_width);
    showgrey(psf)
    title(sprintf('add w = %0.2f', w_width))
end

% 2.2 Salt and pepper noise
for i = 1 : length(t_values)
    w_width = w_widths(i);
    subplot(5,2,(i*2)+2)
    psf = medfilt(sap, w_width);
    showgrey(psf)
    title(sprintf('sap w = %0.2f', w_width))
end
%------------------------------------------


%------ 3. Ideal low-pass filtering -------
figure
subplot(5, 2, 1);
showgrey(add)
title('add');
subplot(5, 2, 2);
showgrey(sap)
title('sap');
cuttoffs = [0.4, 0.3, 0.2, 0.1];
% 3.1 Gaussian noise
for i = 1 : length(cuttoffs)
    cuttoff = cuttoffs(i);
    subplot(5,2,(i*2)+1)
    psf = ideal(add, cuttoff);
    showgrey(psf)
    title(sprintf('add c = %0.2f', cuttoff))
end

% 3.2 Salt and pepper noise
for i = 1 : length(cuttoffs)
    cuttoff = cuttoffs(i);
    subplot(5,2,(i*2)+2)
    psf = ideal(sap, cuttoff);
    showgrey(psf)
    title(sprintf('sap c = %0.2f', cuttoff))
end
%------------------------------------------


