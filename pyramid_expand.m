function [expanded] = pyramid_expand(image1,image2)

row_target = size(image2,1)-500;
row = size(image1);
disp(row_target)
  
while row < row_target
    image1 = impyramid(image1,'expand');
    row = size(image1,1);
     disp('expanded')
     disp(row)
     disp('row_target')
     disp(row_target)
    
end   
expanded = image1;

