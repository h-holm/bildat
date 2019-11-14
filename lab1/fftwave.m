function fftwave(u, v, sz)
    % FFTWAVE(u coord, v coord, size)

    if (nargin <= 0) 
    error('Requires at least two input arguments.') 
    end
    if (nargin == 2) 
    sz = 128;
    end
    
    figure

    % zeros(N) returns an N-by-N matrix of zeros.
    Fhat = zeros(sz);
    % Set the following user-specified point to 1.
    Fhat(u, v) = 1;

    % https://se.mathworks.com/help/matlab/ref/ifft2.html
    F = ifft2(Fhat);
    Fabsmax = max(abs(F(:)));

    subplot(3, 2, 1);
    showgrey(Fhat);
    title(sprintf('Fhat: (u, v) = (%d, %d)', u, v))

    % What is done by these instructions?
    if (u <= sz/2)
    uc = u - 1;
    else
    uc = u - 1 - sz;
    end
    if (v <= sz/2)
    vc = v - 1;
    else
    vc = v - 1 - sz;
    end
    sprintf('sz=%d, u=%d, v=%d, uc=%d, vc=%d', sz, u, v, uc, vc)

    %----- Q4 ----------------
    % Wavelength lambda
    w_1 = 2 * pi * uc / sz;
    w_2 = 2 * pi * vc / sz;
    wavelength = 2 * pi / sqrt(w_1^2 + w_2^2);
    %--------------------------

    %----- Q3 -----------------
    % Amplitude A
    % In IFFT2, a factor 1/N^2 is used. This means the FFT 
    % is implemented using a factor 1. In our case, the IFFT
    % uses a factor 1/sz = *1/128.
    % max(abs(Fhat(:))) = 1 since the only non-zero point equals 1.
    % 1 / sz = 1 / 128 = 0.0078
    amplitude = max(abs(Fhat(:)) / sz)
    %---------------------------

    subplot(3, 2, 2);
    showgrey(fftshift(Fhat));
    title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))

    subplot(3, 2, 3);
    showgrey(real(F), 64, -Fabsmax, Fabsmax);
    title('real(F)')

    subplot(3, 2, 4);
    showgrey(imag(F), 64, -Fabsmax, Fabsmax);
    title('imag(F)')

    subplot(3, 2, 5);
    showgrey(abs(F), 64, -Fabsmax, Fabsmax);
    title(sprintf('abs(F) (amplitude %f)', amplitude))

    subplot(3, 2, 6);
    showgrey(angle(F), 64, -pi, pi);
    title(sprintf('angle(F) (wavelength %f)', wavelength))
    

