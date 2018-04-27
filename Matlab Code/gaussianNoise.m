function [I] = gaussianNoise(I)
    [num_righe, num_col]=size(I);
    for i=1:num_righe
        for j=1:num_col
            I(i,j)=I(i,j)+floor(25*randn(1,1));
        end
    end
end