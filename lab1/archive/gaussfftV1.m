function response = gaussfft(pic, t)
%  GAUSSFFT(IMAGE MATRIX, VARIANCE)
%    performs Gaussian filtering using FFT.

ftransform = fft2(inpic);

[xsize ysize] = size(ftransform);
[x y] = meshgrid(0 : xsize-1, 0 : ysize-1);

pixels = real(ifft2(exp(sigma2 * (cos(2 * pi*(x / xsize)) + cos(2 * pi*(y / ysize)) - 2)) .* ftransform));

ftransform = fft(pic);

% Create coordinate system (x down, y right?).
[x_dim, y_dim] = size(pic)
% [x_axis, y_axis] = meshgrid((-x_dim/2):(x_dim/2 - 1), (-y_dim/2):(y_dim/2 - 1))
[x_axis, y_axis] = meshgrid(0:x_dim, 0:y_dim);
x_axis = x_axis - x_dim/2;
y_axis = y_axis - y_dim/2;
showgrey([x_axis, y_axis])
coord_syst = x_axis + y_axis
showgrey(coord_syst)

% Move position of the origin.
% showgrey(fftshift(coord_syst))

% Our Gaussian filter.
gaussian_kernel = 1/(2*pi*t)*exp(-(x.^2+y.^2)./(2*t));

% Compute the (spatial) covariance matrix of the Gaussian function.
cov_mtrx = variance(psf);

% Compare to the ideal continuous case (for which the covariance matrix
% is t multiplied by the identity matrix).


    
    %1. Generate a filter based on a sampled version of the Gaussian function
    %gaussian kernel - start with sampling points
    [xdim, ydim] = size(pic);
    [x, y] = meshgrid(-xdim/2 : (xdim/2)-1, -ydim/2 : (ydim/2)-1);
    
    gaussian_kernel = 1/(2*pi*t)*exp(-(x.^2+y.^2)./(2*t)); %the filter
    
    %2. Fourier transform the original image and the Gaussian filter.
    pic_hat = fft2(pic);
    gaussian_hat = fft2(gaussian_kernel);
    
    %3. Multiply the Fourier transforms.
    convolved_image = (pic_hat .* gaussian_hat);
    
    %4. Invert the resulting Fourier transform.
    inverted_pic = ifft2(convolved_image);
    out = fftshift(inverted_pic);
    
    %if we want to plot the freq domain instead
    %out = multiplication;
    
end
    