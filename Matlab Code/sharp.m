function[M,laplAppl] = sharp(I)
    [num_righe, num_col]=size(I);
    s=2;
    t=s;
    I=double(I);
    L=[0,-1,0;-1,4,-1;0,-1,0;];
    L=double(L);
    M=zeros(num_righe,num_col);
    laplAppl=M;
    for i=1:num_righe-s
        for j=1:num_col-t
            laplAppl(i:i+s,j:j+t)=conv2(L,I(i:i+s,j:j+t),'valid');
            M(i:i+s,j:j+t)=I(i:i+s,j:j+t)+conv2(L,I(i:i+s,j:j+t),'valid');
        end
    end
end