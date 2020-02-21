clear all
close all
clc
%% Introduction
% CS 543 
% Spring 2018 
% Qian Chen
% Assignment0 link:
% http://slazebni.cs.illinois.edu/spring18/assignment0.html

%% Start Code
% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)


% name of the input file
% read the image, switch the images by Ctrl + R and Ctrl + T

% imname = '01047u.tif';    
% imname = '01657u.tif';  
imname = '01861a.tif';


% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

%cropping parameter 
[image_height,image_width] = size(B); %original size
chopped_val_h = 100; %chopping the image on height
chopped_val_w = 100; %chopping the image on width

%get rid of the 20*20 border, remain the center image value

B_chopped = B(chopped_val_h+1:image_height-chopped_val_h,chopped_val_w+1:image_width - chopped_val_w);
G_chopped = G(chopped_val_h+1:image_height-chopped_val_h,chopped_val_w+1:image_width - chopped_val_w);
R_chopped = R(chopped_val_h+1:image_height-chopped_val_h,chopped_val_w+1:image_width - chopped_val_w);




% open figure

subplot(1,3,1)
imshow(imname);
title('Original Image Sources')
%% figure(1);

subplot(1,3,2)

% create a color image (3D array)
% ... use the "cat" c
image_original = cat(3, B, G,R);
imshow(image_original);
title('Images without Align')

% Align the images ????????
% Functions that might be useful to you for aligning the images include:
% "circshift", "sum", and "imresize" (for multiscale)

B_reduced = pyramid_reduce(B_chopped);
G_reduced = pyramid_reduce(G_chopped);
R_reduced = pyramid_reduce(R_chopped);


shift_value_newR = align_bonus(R_reduced,G_reduced);
shift_value_newR_expanded = shift_value_newR*2^3;
display('Red Shift')
display(shift_value_newR_expanded)

aR = circshift(R_chopped, shift_value_newR_expanded);

shift_value_newB = align_bonus(B_reduced,G_reduced);
shift_value_newR_expanded = shift_value_newB*2^3;
display('Blue Shift')
display(shift_value_newR_expanded)
aB = circshift(B_chopped,shift_value_newR_expanded );


% aR = pyramid_expand(newR,R_chopped);
% aB = pyramid_expand(newB,B_chopped);
% aG = pyramid_expand(G_reduced,G_chopped);

% [aR,aB,aG] = pyramid_reduce(B_chopped,G_chopped,R_chopped);



% show the resulting image
subplot(1,3,3)
image_fitted = cat(3, aR, G_chopped, aB);

imshow(image_fitted)
title('Cropped Images with Align')
figure(2)
imshow(image_fitted)


% save result image
%% imwrite(colorim,['result-' imname]);