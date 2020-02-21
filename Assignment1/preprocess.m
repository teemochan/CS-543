function [imarray] = preprocess(image_size, ambient_image,imarray)
% subtract the ambient image from each image in the light source stack, set
% any negative values to zero, rescale the resulting intensities to between
% 0 and 1 (they are originally between 0 and 255).

for h = 1:image_size(:,1)
    for w = 1:image_size(:,2)
        % subtract the ambient image(ambient_image) from each image in the light source
        % stack(imarry)
        imarray(h,w,:)=(imarray(h,w,:))-ambient_image(h,w);
        % set any negative values to zero
        if imarray(h,w,:) < 0
            imarray(h,w,:) = 0;
        end
        % rescale values in imarray to be between 0 and 1
        imarray(h,w,:) =imarray(h,w,:)/255;
    end
end
end

