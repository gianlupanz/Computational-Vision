function [M] = fl_mediano_ad2(I)
    I=saltpepper(I,5);
    [num_righe num_col]=size(I);
    M=I;
    smax=8;
    for i=1:num_righe-8
        for j=1:num_col-8
            raggio=2;
            while (raggio<=smax)
                window=I(i:i+raggio,j:j+raggio);
                MM=window;
                window_ord=sort(window(:));
                Zmax=max(window_ord(:));
                Zmin=min(window_ord(:));
                i_mediano=round(length(window_ord)/2);
                Zmediano=window_ord(i_mediano);
                if(Zmediano>Zmin && Zmediano<Zmax)
                    [mw nw]=size(window);
                    for rr=1:mw
                        for cc=1:nw
                            if(window(rr,cc)<=Zmin || window(rr,cc)>=Zmax)
                                MM(rr,cc)=Zmediano;
                            end
                        end
                    end
                    M(i:i+raggio,j:j+raggio)=MM;
                    break;
                end
                raggio=raggio+1;
            end
        end
    end
end