% function [aR,aB,aG] = pyramid_reduce(image1,image2,image3)
function [reduced] = pyramid_reduce(image1)

[row] = size(image1,1);
% counter = 0;
while row >= 400
    %     image1 = impyramid(image1,'reduce');
    %     image2 = impyramid(image2,'reduce');
    %     image3 = impyramid(image3,'reduce');
    %     row = size(image1,1);
    %     counter=counter+1;
    image1 = impyramid(image1,'reduce');
    row = size(image1,1);
end
reduced = image1;


% shift_reg1 = SSD(image3,image2);
% shift_reg2 = SSD(image1,image2);
%
% shift_reg1_expand = shift_reg1*counter;
% shift_reg2_expand = shift_reg2*counter;
%
%
% for  i = 1:counter
%     image1 = impyramid(image1,'expand');
%     image2 = impyramid(image2,'expand');
%     image3 = impyramid(image3,'expand');
% end
%
% aR = align_bonus(image3,image2,shift_reg1_expand,shift_reg2_expand);
% aB = align_bonus(image1,image2,shift_reg1_expand,shift_reg2_expand);
% aG = image3;
%

