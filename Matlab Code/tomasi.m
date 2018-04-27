function [I] = tomasi(I,s)
    if(ndims(I) == 3)
        I = rgb2gray(I);
    end
    
    [num_righe, num_col]=size(I);
    I=double(I);
    
    I_x=zeros(num_righe,num_col);
    I_y=I_x;
    A=I_y;
    B=A;
    C=B;
    
    %calcolo I_x e I_y per ogni pixel
    for i=s:num_righe-s
        for j=s:num_col-s
        % maschera del kernel (s+1)*(t+1)
        I_x(i,j)=I(i+1,j)-I(i-1,j);
        I_y(i,j)=I(i,j+1)-I(i,j-1);
        % T=I(i:i+s,j:j+t);
        % M(i:i+s,j:j+t)=A;
        end
    end
    
    %calcolo A(x,y)
    for i=s:num_righe-s
        for j=s:num_col-s
        % maschera del kernel (s+1)*(t+1)
            for ii=i:i+s
                for jj=j:j+s
                    A(i,j)=A(i,j)+I_x(ii,jj)^2;
                end
            end
           
        end
    end
   
    %calcolo B(x,y)
    for i=s:num_righe-s
        for j=s:num_col-s
            % maschera del kernel (s+1)*(t+1)
            for ii=i:i+s
                for jj=j:j+s
                    B(i,j)=B(i,j)+I_y(ii,jj)^2;
                end
            end
            
        end
    end
    
    %calcolo C(x,y)
    
    for i=s:num_righe-s
        for j=s:num_col-s
            % maschera del kernel (s+1)*(t+1)
            C(i,j)=C(i,j)+A(i,j)*B(i,j);
            
        end
    end
    
    k=10^7;
    hold on
    for rr=1:num_righe
        for cc=1:num_col
            M=[A(rr,cc),C(rr,cc);
            C(rr,cc),B(rr,cc);];
            lambda=eig(M);
            ind_lambda_div_0=find(lambda>0);
            lambda_new=zeros(length(ind_lambda_div_0)-1);
            for kk=1:length(ind_lambda_div_0)
                lambda_new(kk)=lambda(ind_lambda_div_0(kk));
            end
            if isempty(ind_lambda_div_0)
                lambda_min=0;
            else
                lambda_min=min(lambda_new);
            end
            if lambda_min>=k
                I(rr,cc)=64;
            end
        end
    end
  
    
end