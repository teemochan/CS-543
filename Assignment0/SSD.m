function [ x,y ] = SSD(image1,image2)

SSD_inital = inf; % initial SSD value guess

for x = -10:10 % horizontal direction moving parameter
    for y = -10:10 % vertical direction moving parameter
        image_shifted = circshift(image1, [x y]); %æÿ’Û—≠ª∑∆Ω“∆
        SSD = sum(sum((image2-image_shifted).^2)); %sum of squared differences (SSD)
        if SSD < SSD_inital
            SSD_inital = SSD;
            
            shift_reg = circshift(image1, [x y]);
            %             step = image1
            shift_value = [x y];
            disp('image2')
            disp(shift_value)
        end
    end
end
end


