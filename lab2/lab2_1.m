% Henrik Holm - henholm@kth.se

% Q1 ----------------------------------------
% What do you expect the results to look like and why? Compare the size
% of dxtools with the size of tools. Why are these sizes different?
close
clear all

% Two difference operators that approximate the first order partial
% derivatives in two orthogonal directions. Dig. Img Proc. p. 166.

% Robert's diagonal operator.
% deltay = [0 -1; 1 0];

% Sobel operator.
deltay = [1 2 1; 0 0 0; -1 -2 -1];
% deltax = [-1 0 1; -2 0 2; -1 0 1];
deltax = deltay';

% Input image.
tools = few256;

% Compute discrete derivation approximations.
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

figure

subplot(2, 1, 1);
showgrey(dxtools)
title('deltax')
subplot(2, 1, 2);
showgrey(dytools)
title('deltay')

%Compare size of tools and dxtools
size_tools = size(tools)
size_dxtools = size(dxtools)
% ------------------------------------------