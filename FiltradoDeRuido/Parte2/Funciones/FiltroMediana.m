function [If] = FiltroMediana(I, H,relleno)
    [N M] = size(I);
    Nv = H(1);
    Mv = H(2);
    if strcmp(relleno, 'zeros')
        %Ampliacion con ceros
        Iamp = zeros(N+Nv-1,M+Mv-1);
        Ni = floor(Nv/2);
        Mi = floor(Mv/2);
        %Meto la I en la ampliada dejando los filos a ceros
        Iamp(Ni+1:N+Ni,Mi+1:M+Mi) = I;
    else
        Ni = floor(Nv/2);
        Mi = floor(Mv/2);
        
        Iamp = padarray(I,[Ni Mi], relleno);
    end
    %Iamp = double(Iamp);
    Fi = floor(Nv/2);
    Ci = floor(Mv/2);
    If = zeros(N,M);
    for i = Fi+1:N+Fi
        for j = Ci+1:M+Ci
            vecindad = Iamp(i-Fi:i+Fi,j-Ci:j+Ci);
            Vord = sort(vecindad,'ascend');
            If(i-Fi,j-Ci) = median(Vord(:));
        end
    end
end

