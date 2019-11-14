% Henrik Holm, 2019-11-12

% 2.1 - 2.3 ---------------
% Q14 - What are the variances of your discretized Gaussian 
% kernel for different values of t?

close
clear all

% deltafcn(128, 128) generates a discrete delta function of 128*128 size,
% in which the central pixel is set to one, all others to zero.
pic = deltafcn(128, 128);
% pic = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
%         [zeros(128, 48) ones(128, 32) zeros(128, 48)];
% pic = phonecalc128;
% pic = few128;
% pic = nallo128;

figure

subplot(3, 2, 1)
showgrey(pic)
title('Original')
 
t_values = [0.1, 0.3, 1.0, 10.0, 100.0];

for i = 1:length(t_values)
    t = t_values(i);
    

    psf = gaussfft(pic, t);
    subplot(3, 2, i+1)
    
    % Fourier/frequency domain。 fftshift shifts the quadrants around.
    % psf = fftshift(psf);
    % showfs(psf)
    
    showgrey(psf)
    title(sprintf('t = %0.2f', t))
    
    % Compute the (spatial) covariance matrix of the Gaussian function.
    cov_mtrx = variance(psf)
    
    % Compare to the ideal continuous case (for which the covariance matrix
    % is t multiplied by the identity matrix).
    ideal_cont_cov_mtrx = diag([1 1]) .* t
end
%--------------------------


% Q15 ---------------------
% Are the results different from or similar to the estimated variance?
% How does the result correspond to the ideal continuous case?
clear
close all

pic = deltafcn(128, 128);

t_values = [0.1, 0.3, 1.0, 10.0, 100.0];

for i = 1 : length(t_values)
    t = t_values(i);
    psf = gaussfft(pic, t);
    
    our_cov_mtrx = variance(psf);
    
    ideal_psf_disc = discgaussfft(pic, t);
    ideal_disc_cov_mtrx = variance(ideal_psf_disc);
    
    % Variance for the ideal continuous case.
    ideal_cont_cov_mtrx = diag([1 1]) .* t;
    
    % Compare the variance to the estimated variances.
    disc{i} = abs(ideal_disc_cov_mtrx - our_cov_mtrx);
    cont{i} = abs(ideal_cont_cov_mtrx - our_cov_mtrx);
end
celldisp(disc)
celldisp(cont)
%--------------------------


% Q16 ---------------------
% Convolve a couple of images. What effects can you observe?
close
clear all

% deltafcn(128, 128) generates a discrete delta function of 128*128 size,
% in which the central pixel is set to one, all others to zero.
% pic = deltafcn(128, 128);
% pic = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
%         [zeros(128, 48) ones(128, 32) zeros(128, 48)];
% pic = phonecalc128;
% pic = few128;
pic = nallo128;

figure

subplot(3, 2, 1)
showgrey(pic)
title('Original')
 
t_values = [1.0, 4.0, 16.0, 64.0, 256.0];

for i = 1:length(t_values)
    t = t_values(i);
    
    psf = gaussfft(pic, t);
    subplot(3, 2, i+1)
    
    showgrey(psf)
    title(sprintf('t = %0.2f', t))
end
%--------------------------
