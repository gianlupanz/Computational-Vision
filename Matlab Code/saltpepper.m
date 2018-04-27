function [I] = saltpepper(I,p)
    [num_righe, num_col]=size(I);
    for i=1:num_righe
        for j=1:num_col
            %aggiungi rumore salt and pepper
            s=randi(p);
            if s==p
                if randi(2)==1
                    I(i,j)=0;
                else
                    I(i,j)=255;
                end
            end
        end
    end
end