function [M] = fl_gauss(I,s)
    t = s
    [num_righe, num_col]=size(I);
    sigma=round((2*s+1)/5);
    %I=imnoise(I, 'gaussian');
    %
    for i=1:num_righe
        for j=1:num_col
            %aggiungi rumore
            I(i,j)=I(i,j)+floor(45*randn(1,1));
        end
    end
    M=I;
    H=gauss_kernel(s+1,sigma);
    h_min=min(H(:));
    H=round(H/h_min);
    den=sum(H(:));
    H=double(H/den);
    for i=1:num_righe-s
        for j=1:num_col-t
            %maschera del kernel (s+1)*(t+1)
            T=I(i:i+s,j:j+t);
            T=double(T);
            A=conv2(H,T,'valid');
            M(i:i+s,j:j+t)=A;
            % pause
        end
    end
end
    
function K = gauss_kernel(N,std)
    % Filtro Gaussiano
    % - N = Dimensione (NxN) del filtro
    % - std = deviazione standard
    % - K = kernel gaussiano
    dim = (N-1)/2;
    % preparazione griglia
    [x,y] = meshgrid(-dim:dim,-dim:dim);
    arg = -(x.*x + y.*y)/(2*std^2);
    % funzione di Gauss
    K = exp(arg);
    K=double(K);
end