% Henrik Holm - henholm@kth.se

% Q9 ----------------------------------------
% How do the results and computational time depend on the 
% number of cells in the accumulator?
close
clear all

% Initialize our input parameters.
pic = few256;
% [nrho, ntheta] = size(pic);
threshold = 20;
scale = 10;
nlines = 10;
verbose = 0;

start_time = cputime

% Test for different values of nrho and ntheta. This corresponds
% to changing the number of cells in the accumulator.
% The actual dimensions of the image are 256x256.
nrho = 1000;
ntheta = 100;

% Call the function.
[linepar, acc] = houghedgeline(pic, scale, threshold, nrho, ntheta, nlines, verbose);
time_elapsed = cputime - start_time
% ------------------------------------------