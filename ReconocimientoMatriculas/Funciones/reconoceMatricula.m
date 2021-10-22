%Funcion que devuelve un string en el que estan todos los caracteres de la
%matricula, tiene como entrada la imagen original y el numero de caracteres
%que hay en ella
function [res] = reconoceMatricula(Irgb,numCaracteres)
    %imshow(Irgb)
    ListaCarac = '0123456789ABCDFGHKLNRSTXYZ';

    addpath(genpath('../Material_Imagenes_Plantillas'));
           
    I = Irgb(:,:,1);
    %imshow(I);
    If = filtraImagen(I);
    %figure, imshow(If);
    W = [75, 51];
    const = 9;
    [Iu Imeds Ides] = UmbralizaLocal(If, W, const);
    %figure, imshow(Iu);
%     Iu = ordfilt2(Iu,1,ones(5));
%     Iu = ordfilt2(Iu,25,ones(5));
    %figure, imshow(Iu);
    [Ietiq carac] = etiquetaImagen(Iu,numCaracteres);
    %figure, imshow(Ietiq)
    ncc = correlacionCaracteres(Ietiq, carac);
    res = [];
    for i = 1:numCaracteres
       correlacionCarac = ncc(:,:,i);
       [objeto angulo] = find(correlacionCarac == max(correlacionCarac(:)));
       res = [res ListaCarac(objeto)];
    end
    
    stats = regionprops(Ietiq,'BoundingBox','Centroid');
    figure, imshow(Irgb),hold on;
    for i = 1:numCaracteres
        rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);
        centroide = ceil(stats(i).Centroid);
        plot(centroide(1),centroide(2),'r*');
    end
end

