function pixels = Lvvtilde(inpic, shape)
% Lvvtilde function
% Define masks of size 5x5 (as given in the lab description).

% 1st order derivative.
dxmask = [0 0 0 0 0;
          0 0 -1/2 0 0;
          0 0 0 0 0;
          0 0 1/2 0 0;
          0 0 0 0 0];
dymask = dxmask';

% 2nd order derivative.
dxxmask = [0 0 0 0 0;
           0 0 1 0 0;
           0 0 -2 0 0;
           0 0 1 0 0;
           0 0 0 0 0];
dyymask = dxxmask';

% "Approximations of higher order derivatives can then be created by
%  applying these in cascade."
%      In MATLAB, the concatenation of two masks is performed with the 
% functions filter2 or conv2, with the argument 'shape' set to 'same'.
%      Concatenate the two masks by convolution (i.e. by using a 
% filtering operation).
dxymask = conv2(dxmask, dymask, shape);

% Compute the smoothened intensity function L by convolution.
% Compute all of the partial derivatives.
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxx = filter2(dxxmask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);

% Compute the output approximatons of the gradient magnitudes of the 
% input image. Use the equation found on page 3 in the lab description.
pixels = Lx.^2 .* Lxx + 2*Lx.*Ly.*Lxy + Ly.^2 .* Lyy;

end
