%teniendo como entrada la imagen y el numero de caracteres esta funcion
%devuleve una imagen etiquetada unicamente con los caracteres de interes 
%(Se elimina cualquie cosa que no sea caracter) y una matriz en la que se
%guardan los valores de las etiquetas
function [Ietiq caracteres] = etiquetaImagen(I,numCaracteres)
    
    Ietiq = bwlabel(I);
    [F C] = size(Ietiq);
    
    Fc = floor(F/2) + 1;
    objetos = unique(Ietiq(Fc,:));
    caracteres = objetos(3:length(objetos));
    
    Ib = ismember(Ietiq, caracteres);
    Ib = bwareafilt(Ib, numCaracteres);
    Ietiq = bwlabel(Ib);
    caracteres = unique(Ietiq);
    caracteres(1) = [];
end

