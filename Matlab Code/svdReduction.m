function [I_temp] = svdReduction(I)
    I=double(I);
    [U,S,V]=svd(I);
    U_ridotta=U(:,1:2);
    S_ridotta=S(1:2,1:2);
    V_ridotta=V(:,1:2);
    I_temp=U_ridotta*S_ridotta*V_ridotta';
    dim=size(I_temp);
end