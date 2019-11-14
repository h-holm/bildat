function response = gaussfft(input_image, t)
    %  GAUSSFFT(IMAGE MATRIX, VARIANCE)
    %    performs Gaussian filtering using FFT.

    % Create coordinate system (x down, y right?).
    [xsize, ysize] = size(input_image);
    [x, y] = meshgrid(-xsize/2 : (xsize/2)-1, -ysize/2 : (ysize/2)-1);
    % showgrey([x y])

    % 1. Generate a filter based on a sampled version of the Gaussian function.
    % Gaussian filter using the discretized version of formula (8).
    gaussian_kernel = 1/(2*pi*t) * exp(-(x.^2+y.^2)./(2*t));
    % showgrey(gaussian_kernel)

    % 2. Fourier transform the original image and the Gaussian filter.
    image_ftransform = fft2(input_image);
    kernel_ftransform = fft2(gaussian_kernel);

    % 3. Calculate product of the Fourier transforms.
    convolved_image = (image_ftransform .* kernel_ftransform);

    % 4. Compute inverse Fourier transform of resulting image.
    inverted_image = ifft2(convolved_image);
    response = fftshift(inverted_image);
end
    