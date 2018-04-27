function [Ibw] = canny(x)

    Nx1=10;Sigmax1=2;Nx2=10;Sigmax2=2;Theta1=pi/2;
    Ny1=10;Sigmay1=2;Ny2=10;Sigmay2=2;Theta2=0;
    
    % Calcolo il gradiente su x
    filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
    Ix= conv2(double(x),double(filterx),'same');

    % Calcolo il gradiente su y
    filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
    Iy=conv2(double(x),double(filtery),'same'); 

    % Calcolo la norma del gradiente
    NVI=sqrt(Ix.*Ix+Iy.*Iy);
    
    % Applico la sogliatura
    I_max=max(max(NVI));
    I_min=min(min(NVI));
    level=0.1*(I_max-I_min)+I_min;
    Ibw=max(NVI,level.*ones(size(NVI)));
    
end


function h = d2dgauss(n1,sigma1,n2,sigma2,theta)
    r=[cos(theta) -sin(theta);
       sin(theta)  cos(theta)];
    for i = 1 : n2 
        for j = 1 : n1
            u = r * [j-(n1+1)/2 i-(n2+1)/2]';
            h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);
        end
    end
    h = h / sqrt(sum(sum(abs(h).*abs(h))));
end


function y = dgauss(x,std)
    y = -x * gauss(x,std) / std^2;
end

function y = gauss(x,std)
    y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));
end


