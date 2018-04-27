function [ fin ] = unsharp(I)
    s=2;
    t=s;
    [num_righe, num_col]=size(I);
    M=I;
    L=[1,2,1;1,-8,1;1,2,1;];
    for i=1:num_righe-s
        for j=1:num_col-t
            %maschera del kernel (s+1)*(t+1)
            T=I(i:i+s,j:j+t);
            [m,n]=size(T);
            %filtro media per fare il blur
            media=sum(T(:))/(m*n);
            M(i:i+s,j:j+t)=conv2(L,media,'valid');
        end
    end
    sottr=(I-M);
    fin=sottr+I;
end