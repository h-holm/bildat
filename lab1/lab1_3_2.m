% Henrik Holm, 2019-11-12

% 3.2 -------------------------------------
close
clear all

%------------------------------------------
% Q19. What effects do you observe when subsampling the original image
% and the smoothed variants?

img = phonecalc256;
smooth_img_gaussian = img;
smooth_img_ideal = img;

figure

N = 5;
for i = 1:N
    if i>1 % generate subsampled versions        
        img = rawsubsample(img);
        smooth_img_gaussian = gaussfft(smooth_img_gaussian, 0.6);
        smooth_img_ideal = ideal(smooth_img_ideal, 0.28);
        
        smooth_img_gaussian = rawsubsample(smooth_img_gaussian);
        smooth_img_ideal = rawsubsample(smooth_img_ideal);
    end
    
    subplot(3, N, i)
    showgrey(img)
    title('Original');
    
    subplot(3, N, i+N)
    showgrey(smooth_img_gaussian)
    title('Gaussian filter');
    
    subplot(3, N, i+2*N)
    showgrey(smooth_img_ideal)
    title('Ideal filter');
end