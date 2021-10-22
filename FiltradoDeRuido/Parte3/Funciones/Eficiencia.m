function [ISNR] = Eficiencia(I,Ir,If)
    Ruido1 = (double(I) - double(Ir)).^2;
    numerador = sum(Ruido1(:));
    Ruido2 = (double(I) - double(If)).^2;
    denominador = sum(Ruido2(:));
    
    ISNR = 10*log10(numerador/denominador);
end

