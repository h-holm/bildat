Fhat = zeros(128, 128);
% Set one pixel to 1.
Fhat(5, 9) = 1;
% Fhat(9, 5) = 1;
% Fhat(17, 9) = 1;
% Fhat(17, 121) = 1;
% Fhat(5, 1) = 1;
% Fhat(125, 1) = 1;
% Fhat(64, 64) = 1;
% Fhat(119, 123) = 1;

% Compute its inverse DFT (IDFT).
F = ifft2(Fhat);

Fabsmax = max(abs(F(:)));



subplot(2, 2, 1);
showgrey(real(F), 64, -Fabsmax, Fabsmax)
title(sprintf('Real'))

subplot(2, 2, 2);
showgrey(imag(F), 64, -Fabsmax, Fabsmax)
title(sprintf('Imaginary'))

subplot(2, 2, 3);
showgrey(abs(F), 64, -Fabsmax, Fabsmax)
title(sprintf('Magnitude / abs'))

subplot(2, 2, 4);
showgrey(angle(F), 64, -pi, pi)
title(sprintf('Phase / angle'))