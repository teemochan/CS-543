function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
%% instruction
% Estimate the albedo and surface normals. For this, you need to fill in
% code in photometric_stereo.m, which is a function taking as input the
% image stack corresponding to the different light source directions and
% the matrix of of the light source directions, and returning an albedo
% image and surface normal estimates. The latter should be stored in a
% three-dimensional matrix. That is, if your original image dimensions are
% h x w, the surface normal matrix should be h x w x 3, where the third
% dimension corresponds to the x-, y-, and z-components of the normals. To
% solve for the albedo and the normals, you will need to set up a linear
% system as shown in slide 20 of Lecture 4.

%% Variable
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals
%% Hints
% To get the least-squares solution of a linear system, use MATLAB's
% backslash operator. That is, the solution to Ax = b is given by x = A\b.

% If you directly implement the formulation of slide 20 of the lecture, you
% will have to loop over every image pixel and separately solve a linear
% system in each iteration. There is a way to get all the solutions at once
% by stacking the unknown g vectors for every pixel into a 3 x npix matrix
% and getting all the solutions with a single application of the backslash
% operator. 

% You will most likely need to reshape your data in various ways
% before and after solving the linear system. Useful MATLAB functions for
% this include reshape and cat. 

% You may also need to use element-wise
% operations. For example, for two equal-size matrices X and Y, X .* Y
% multiplies corresponding elements, and X.^2 squares every element. As
% before, bsxfun can also be a very useful function here.

%% <<< fill in your code below >>>
h = size(imarray,1);
w = size(imarray,2);
Nimages = size(imarray,3);

surface_normals = zeros(h,w,3);
g= zeros(3,1);

for i = 1:h
    for j = 1:w
        I = reshape(imarray(i,j,:),[Nimages,1]);
        g = light_dirs\I;
        albedo_image(i,j) = norm(g);
        surface_normals(i,j,:)=g/albedo_image(i,j);
    end
end
        
        
     
end

