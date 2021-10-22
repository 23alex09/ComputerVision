function [Iruido] = RuidoGaussiano(I, media, desviacion)
    [N M] = size(I);
    x = randn(N,M);
    X = media + x*desviacion;
    I = double(I);
    Iruido = I + X;
    Iruido = uint8(Iruido);
end

