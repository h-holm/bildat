% Henrik Holm - henholm@kth.se

% Q8 ----------------------------------------
% Identify the correspondences between the strongest peaks in the 
% accumulator and line segments in the output image. Doing so 
% convince yourself that the implementation is correct. Summarize 
% the results in one or more figures.

close
clear all

% Load images as defined in lab description.
testimage1 = triangle128;
smalltest1 = binsubsample(testimage1);

testimage2 = houghtest256;
smalltest2 = binsubsample(binsubsample(testimage2));

% Initialize our input parameters.
% pic = few256;
% pic = binsubsample(few256);
% pic = phonecalc256; % t20, sc13, nl12
% pic = godthem256;
pic = testimage1;
% pic = smalltest1;
% pic = testimage2;
% pic = smalltest2;
[nrho, ntheta] = size(pic);
threshold = 20;
scale = 13;
nlines = 3;
verbose = 0;

% Call the function.
[linepar, acc] = houghedgeline(pic, scale, threshold, nrho, ntheta, nlines, verbose);
% ------------------------------------------