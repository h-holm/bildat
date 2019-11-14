% Henrik Holm, 2019-11-11


%--------------------------
% Q1 - Q6
close
clear all

sz = 128;

p = 5;
q = 9;
figure
fftwave(p, q, sz)

p = 9;
q = 5;
figure
fftwave(p, q, sz)

p = 17;
q = 9;
figure
fftwave(p, q, sz)

p = 17;
q = 121;
figure
fftwave(p, q, sz)

p = 5;
q = 1;
figure
fftwave(p, q, sz)

p = 125;
q = 1;
figure
fftwave(p, q, sz)

p = 64;
q = 64;
figure
fftwave(p, q, sz)

% What happens when we pass the point in the center?
p = 100;
q = 120;
figure
fftwave(p, q, sz)

% fftwave(1, 3, 128)    % For good-looking sine waves in 3D.
%--------------------------


%--------------------------
% Q7 - Why are these Fourier spectra concentrated to the borders of the
% images?

% Define 3 rectangular 128 x 128 pixel test images.
F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

figure

% Display them.
subplot(4, 3, 1);
showgrey(F)
title(sprintf('F'))
subplot(4, 3, 2);
showgrey(G)
title(sprintf('G'))
subplot(4, 3, 3);
showgrey(H)
title(sprintf('H'))

% Compute their Discrete Fourier Transforms.
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

% For experimentation purposes, compute Hhat using Fhat and Ghat. Also
% compute H "backwards", i.e. starting from the frequency domain.
Hhat_2 = Fhat + 2 * Ghat;
H_2 = ifft2(Hhat_2);

% Display their Fourier spectra.
subplot(4, 3, 4);
showgrey(log(1 + abs(Fhat)));
title(sprintf('Fhat'))

subplot(4, 3, 5);
showgrey(log(1 + abs(Ghat)));
title(sprintf('Ghat'))

subplot(4, 3, 6);
showgrey(log(1 + abs(Hhat)));
title(sprintf('Hhat'))

subplot(4, 3, 8);
showgrey(log(1 + abs(H_2)));
title(sprintf('H calculated from frequency domain'))

subplot(4, 3, 9);
showgrey(log(1 + abs(Hhat_2)));
title(sprintf('Hhat calculated from frequency domain'))

subplot(4, 3, 7);
showgrey(log(1 + abs(fftshift(Hhat))));
title(sprintf('log(1 + abs(fftshift(Hhat)))'))
%--------------------------


%--------------------------
% Q8 - Why is the logarithm function applied?
figure

% Plot Fhat.
subplot(2, 1, 1);
surf(abs(Fhat));
title('Fhat');

% Plot log of Fhat.
subplot(2, 1, 2);
surf((log(1 + abs(Fhat))));
title('log(Fhat)');
%--------------------------


%--------------------------
% Q9 - What conclusions can be drawn regarding linearity?
figure

% Redo what we did in Q7, i.e. compute Hhat in two different ways.
% 1. by computing the Fourier transform of H.
Hhat_1 = fft2(H);
% 2. by computing the linear combination of the Fourier transforms of F and
% G respectively (using the same formula as in the spatial domain).
Hhat_2 = fft2(F) + 2*fft2(G);

subplot(2,2,1);
showgrey(1 + abs(fftshift(Hhat_1)));
title('1 + abs(fftshift(Hhat_1))');

subplot(2,2,2)
showgrey(log(1 + abs(fftshift(Hhat_1))));
title('log(1 + abs(fftshift(Hhat_1)))');

subplot(2,2,3);
showgrey(1 + abs(fftshift(Hhat_2)));
title('1 + abs(fftshift(Hhat_2))');

subplot(2,2,4);
showgrey(log(1 + abs(fftshift(Hhat_2))));
title('log(1 + abs(fftshift(Hhat_2)))');
%--------------------------


%--------------------------
% Q10 - Are there any other ways to compute the last image?

% Define 3 rectangular 128 x 128 pixel test images.
F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

size_array = size(F);
sz = size_array(1);

Fhat = fft2(F);
Ghat = fft2(G);

conv = conv2(Fhat, Ghat);
% Since norm_corv is 255 x 255, we reduce it back to 128 x 128 pixels.
norm_conv = conv(1:sz, 1:sz);
norm_conv = norm_conv / sz.^2;

figure

% Original F.
subplot(3,3,1);
showgrey(F);
title('F');

% Original G.
subplot(3,3,4);
showgrey(G);
title('G');

% Multiplication of F and G in the spatial domain.
subplot(3,3,7);
% Element-wise multiplication (point-wise multiplication of matrix elements).
showgrey(F .* G);
title('F .* G');

% Fhat.
subplot(3,3,2);
showgrey(log(1 + abs(fftshift(Fhat))));
title('log(1 + abs(fftshift(Fhat)))');

% Ghat.
subplot(3,3,5);
showgrey(log(1 + abs(fftshift(Ghat))));
title('log(1 + abs(fftshift(Ghat)))');

% Convolution of Fhat and Ghat (i.e. in the Fourier domain).
subplot(3,3,8);
showfs(conv);
title('conv2(Fhat, Ghat)');

% Normalized convolution.
subplot(3,3,3);
showfs(norm_conv);
title('normalized conv2(Fhat, Ghat)');

% This is the target image: Fourier transform of F .* G.
subplot(3,3,9);
% showfs displays a compressed version of the corresponding Fourier 
% spectrum as a gray-level image.
showfs(fft2(F .* G));
title('target: fft2(F .* G))');
%--------------------------


% 1.6 Scaling --------------------------
% Q11 - What conclusions can be drawn from comparing the results with those 
% in the previous exercise?

% F as given in lab description.
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];
Fhat = fft2(F);

% F and G from previous question.
F_old = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G_old = F_old';

figure

subplot(2,2,1);
showgrey(F);
title('F (rescaled)');

subplot(2,2,3);
showfs(Fhat);
title('Fhat (rescaled)');

% Also plot results from previous question.
subplot(2,2,2);
showgrey(F_old .* G_old);
title('F (old)');

% Now show results from previous question, i.e. same multiplication but
% without scaling.
subplot(2,2,4);
showfs(fft2(F_old .* G_old));
title('fft2(F (old) .* G (old)))');
%--------------------------


% 1.7 Rotation ------------
% Q12 - Possible similarities and differences?

figure

alpha = 0;
% alpha = 30;
% alpha = 45;
% alpha = 60;
% alpha = 90;

% F as given in lab description.
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];
G = rot(F, alpha);
showgrey(G)
axis on

Ghat = fft2(G);
Hhat = rot(fftshift(Ghat), -alpha);

subplot(1,3,1);
showgrey(G)
title(sprintf('Spatial - alpha %.*f', 0, alpha));

subplot(1,3,2);
showfs(Ghat)
title(sprintf('Fourier - alpha %.*f', 0, alpha));

subplot(1,3,3);
showgrey(log(1 + abs(Hhat)))
title(sprintf('Fourier - rot back alpha %.*f', 0, alpha));
%--------------------------


% 1.8 ---------------------
% Q13 - What information is contained in the pase and in the magnitude of 
% the Fourier transform?

a = 10^-10;

images = cell(1,3);

images{1} = phonecalc128;
images{2} = few128;
images{3} = nallo128;

figure

for c = 1:size(images, 2)
    subplot(3,3,c);
    showgrey(images{c})
    title('Original');
    
    subplot(3,3,c+3);
    showgrey(pow2image(images{c}, a))
    title(sprintf('pow2image: a = %0.e', a));

    subplot(3,3,c+6);
    showgrey(randphaseimage(images{c}))
    title('randphase');
end
%--------------------------


