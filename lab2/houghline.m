function [linepar, acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)

% 1. Check if input appears valid (or don't).

% 2. Initialize our accumulator space as a zeros-matrix.
% For the dimensions, use nrho and nthetat, which correspond to the 
% number of accumulators in the rho/theta directions respectively.
acc = zeros(nrho, ntheta);

% 3. Use linspace to define a coordinate system for our accumulator
% with equal spacing.

% Discretize the angle theta. Do not include values corresponding to degrees 
% higher than 180 degrees, as -180 to +180 still covers a full circle.
thetas = linspace((-pi/2), (pi/2), ntheta);

% Use the the size of the magnitude image to discretize the values for rho.
nrows = size(magnitude, 1);
ncols = size(magnitude, 2);
D = sqrt((nrows .^ 2) + (ncols .^ 2));
rhos = linspace(-D, D, nrho);

% 4. Draw inspiration from pixelplotcurves() to loop over the curves.
insize = size(curves, 2);
trypointer = 1; 
while trypointer < insize
    curvelength = curves(2, trypointer);
    trypointer = trypointer + 1;
    % 5. Iterate through the points on the curve.
    for curveidx = 1:curvelength
        
        % Get the x and y coordinates.
        x = curves(2, trypointer);
        y = curves(1, trypointer);
            
        % 6. Check if valid point by comparing its intensity value with 
        % the threshold.
        magn_xy = abs(magnitude(round(x), round(y)));
        if magn_xy > threshold   
            % 7. Rotate by iterating over our theta values.
            for theta_idx = 1:ntheta
                % Use the equation for the rho-theta representation of
                % points as defined on page 6 in the lab description.
                % 8. Compute the rho value (vector length) given theta.
                rho_val = x*cos(thetas(theta_idx)) + y*sin(thetas(theta_idx));
                
                % 9. Identify the index value for the point corresponding 
                % the closest to the computed rho value.
                rho_idx = find(rhos < rho_val, 1, 'last');
                
                % 10. Increment the corresponding point in the accumulator 
                % space (i.e. update the accumulator by voting).
                % Different weighting schemes:
                
                % I) Equal weighting.
                acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + 1;
                % II) 1 * magnitude.
                % acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + magn_xy;
                % III) log of magnitude.
                % acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + log(magn_xy);
                % IV) magnitude^2
                % acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + magn_xy .^ 2;
                % V) magnitude^3
                % acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + magn_xy .^ 3;
                % VI) 2^log(magnitude)
                % acc(rho_idx, theta_idx) = acc(rho_idx, theta_idx) + 2 .^ log(magn_xy);
            end
        end
        % Increment the pointer.
        trypointer = trypointer + 1;
    end
end

% 11. Extract local maxima from the accumulator. Use the code segment
% given in the lab description.
% acctmp = acc;
[pos, value] = locmax8(acc);
[~, indexvector] = sort(value);
nmaxima = size(value, 1);

% 12. Compute a line for each of the strongest responses in the
% accumulator. Use code given in lab description.
for index = 1:nlines
    rhoidxacc = pos(indexvector(nmaxima - index + 1), 1);
    thetaidxacc = pos(indexvector(nmaxima - index + 1), 2);
    
    rho = rhos(rhoidxacc);
    theta = thetas(thetaidxacc);
    
    linepar(:,index) = [rho; theta];
    
    % Convert lines defined by rho and theta back to cartesian coordinates.
    x0 = 0;
    % Rearrange the rho = xcos(theta) + ysin(theta) equation in
    % order to solve for y0.
    y0 = (rho - x0 * cos(theta))./sin(theta);
    % Acquire dx from D which was used to discretize rho.
    dx = D .^ 2;
    dy = (rho - dx * cos(theta))./sin(theta);
    
    % Given in the lab description.
    outcurves(1, 4*(index-1) + 1) = 0; % level, not significant
    outcurves(2, 4*(index-1) + 1) = 3; % number of points in the curve
    outcurves(2, 4*(index-1) + 2) = x0 - dx;
    outcurves(1, 4*(index-1) + 2) = y0 - dy;
    outcurves(2, 4*(index-1) + 3) = x0;
    outcurves(1, 4*(index-1) + 3) = y0;
    outcurves(2, 4*(index-1) + 4) = x0+dx;
    outcurves(1, 4*(index-1) + 4) = y0+dy;
end

% Output.
linepar = outcurves;

end