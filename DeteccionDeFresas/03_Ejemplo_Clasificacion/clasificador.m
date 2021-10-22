function ICodif = clasificador(I, factor, media, desviacion)
    CC = [255 128 64 32];
    [f, c, k] = size(I);
    ICodif = zeros(f,c);
    for i = 1:length(CC)
       POI = (I(:,:,1) > media(i, 1) - factor*desviacion(i,1) & I(:,:,1) <= media(i, 1) + factor*desviacion(i,1)) & (I(:,:,2) > media(i, 2) - factor*desviacion(i,2) & I(:,:,2) <= media(i, 2) + factor*desviacion(i,2)) & (I(:,:,3) > media(i, 3) - factor*desviacion(i,3) & I(:,:,3) <= media(i, 3) + factor*desviacion(i,3));
       ICodif(POI) = CC(i);   
    end
end

