function [Iruido] = SalyPimienta(I,p,q)
    [N M] = size(I);
    x = rand(N,M);
    Iruido = I;
    Iruido(p <= x & x < q) = 0;
    Iruido(q <= x & x < 1) = 255;
end

