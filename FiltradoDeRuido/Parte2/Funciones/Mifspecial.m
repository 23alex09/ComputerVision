function [h] = Mifspecial(hsize)
    sigma = hsize/5;
    h = zeros(hsize);
    min = -floor(hsize/2);
    max = floor(hsize/2);
    for i = min:max
        for j = min:max
            numerador = (i^2) + (j^2);
            h(i+max+1,j+max+1) = exp(-(1/2)*(numerador/(sigma^2)));
        end
    end
    
    suma = sum(h(:));
    h = h/suma;
end

