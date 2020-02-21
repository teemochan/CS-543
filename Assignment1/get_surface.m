function  height_map = get_surface(surface_normals, image_size, method)
%% Instruction
% Compute the surface height map by integration. The method is shown in
% slide 23 of Lecture 4, except that instead of continuous integration of
% the partial derivatives over a path, you will simply be summing their
% discrete values. Your code implementing the integration should go in the
% get_surface.m file. As stated in the slide, to get the best results, you
% should compute integrals over multiple paths and average the results.

%% Variable
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object

%% Hint
% You should implement the following variants of integration:

% a. Integrating first the rows, then the columns. That is, your path first goes along the
%    same row as the pixel along the top, and then goes vertically down to the
%    pixel. It is possible to implement this without nested loops using the
%    cumsum function.
% b. Integrating first along the columns, then the rows.
% c. Average of the first two options.
% d. Average of multiple random paths. For this, it is fine to use nested
%    loops. You should determine the number of paths experimentally.

%% <<< fill in your code below >>>

% define the size of h,w, and n
h = image_size(:,1); % column
w = image_size(:,2); % row

% define the size of the object's height map
height_map = zeros(h, w);

p = surface_normals(:,:,1)./surface_normals(:,:,3);%row, x
q = surface_normals(:,:,2)./surface_normals(:,:,3);%column, y

switch method
    case 'column'
        % Integrating first along the rows, then the columns.
        for  r=1:h
            for c = 1:w
                integrate_r = cumsum(p(r,1:c));
                integrate_c = cumsum(q(1:r,1));
                height_map(r,c) = integrate_r(end) + integrate_c(end);
            end
        end
        
    case 'row'
        % Integrating first along the columns, then the rows.
        for c=1:w
            for r=1:h
                integrate_c = cumsum(q(1:r,c));
                integrate_r = cumsum(p(1,1:c));
                height_map(r,c) = integrate_r(end) + integrate_c(end);
            end
        end
        
    case 'average'
        % Get height map data from method column and method row
        height_map_column = get_surface(surface_normals, image_size, 'column');
        height_map_row = get_surface(surface_normals, image_size, 'row');
        % Average of the first two options
        height_map = bsxfun(@plus, height_map_column, height_map_row)*0.5;
        
    case 'random'
        % Average of multiple random paths. For this, it is fine to use
        % nested loops. You should determine the number of paths
        % experimentally.
        path = 100; %experimental number of paths here
        for i=1:path % go through random paths
            for r=-sort(-(1:h))
                for c=-sort(-(1:w))
                    [x, y]=deal(1); % initial coordinates of p & q for each pixel
                    height_map(r,c,i) = p(x,y) + q(x,y);
                    
                     if rand > 0.5 % rand
                            x = x + 1;
                            height_map(r,c,i) = height_map(r,c,i) + q(x,y);
                        else
                            y = y + 1;
                            height_map(r,c,i) = height_map(r,c,i) + p(x,y);
                     end
                     
                    while x<r && y<c % if not complete
                        if rand > 0.5 % rand
                            x = x + 1;
                            height_map(r,c,i) = height_map(r,c,i) + q(x,y);
                        else
                            y = y + 1;
                            height_map(r,c,i) = height_map(r,c,i) + p(x,y);
                        end
                        if x == r 
                            integrate_r = cumsum(p(r,y:c));
                            height_map(r,c,i) = integrate_r(end) + height_map(r,c,i); 
                        end
                        if y == c 
                            integrate_c = cumsum(q(x:r,c));
                            height_map(r,c,i) = integrate_c(end) + height_map(r,c,i);
                        end                       
                    end
                end
            end
        end
        
        
        height_map = sum(height_map,3)./path; % Averaging of multiple paths
end
