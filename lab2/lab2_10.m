% Henrik Holm - henholm@kth.se

% Q10 ----------------------------------------
% How do you propose to do this? Try out a function that you would suggest 
% and see if it improves the results. Does it?
close
clear all

% Initialize our input parameters.
pic = few256;
[nrho, ntheta] = size(pic);
threshold = 20;
scale = 10;
nlines = 10;
verbose = 1;

% A natural choice of accumulator increment is letting the increment 
% always be equal to one. Alternatively, let the accumulator 
% increment be proportional to a function of the gradient magnitude.

% Call the function.
[linepar, acc] = houghedgeline(pic, scale, threshold, nrho, ntheta, nlines, verbose);
% ------------------------------------------