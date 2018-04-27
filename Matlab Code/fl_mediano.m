function [M] = fl_mediano(I,s,t)
    [num_righe, num_col]=size(I);
    I= saltpepper(I,2);
    M=I;
    for i=1:num_righe-s
        for j=1:num_col-t
            %maschera del kernel (s+1)*(t+1)
            T=I(i:i+s,j:j+t);
            %calcolo mediano in un insieme che è ordinato
            T_ord=sort(T(:));
            i_mediano=round(length(T_ord)/2);
            %filtro mediano
            mediano=T_ord(i_mediano);
            % mediano=median(T_ord(:));
            M(i:i+s,j:j+t)=mediano;
        end
    end
end