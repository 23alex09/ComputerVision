%Pasando la imagen etiquetada y los valores de cada una de las areas, esta
%funcion se encarga de por cada caracter, calcular el indice de correlacion
%de dicho caracte con todas las plantillad de letras de las que disponemos
function [ncc] = correlacionCaracteres(Ietiq, carac)
    load Plantillas.mat;
    base1 = 'Objeto';
    base2 = 'Angulo';
    [F C] = size(Ietiq);
    
    ncc = zeros(26,7,length(carac));
    for i = 1:length(carac)
        caracter = carac(i);
        Ib = zeros(F,C);
        Ib(Ietiq == caracter) = 1;
       %figure, imshow(Ib);
        [a b] = find(Ib == 1);
        Fmin = min(a);
        Fmax = max(a);
        Cmin = min(b);
        Cmax = max(b);
        Ibletra = Ib(Fmin:Fmax,Cmin:Cmax);
        %figure, imshow(Ibletra)
        Ibletra = ordfilt2(Ibletra,25,ones(5));
        Ibletra = ordfilt2(Ibletra,1,ones(5));
        %figure,imshow(Ibletra)

        for j = 1:26
            ncc1 = [];
            for k = 1:7
                sentencia = ['T = ' base1 num2str(j,'%02d') base2 num2str(k,'%02d') ';'];
                eval(sentencia);
                [Fletra Cletra] = size(T);
                Ibletra = imresize(Ibletra, [Fletra Cletra]);
                coeficientes = normxcorr2(T,Ibletra);
                ncc(j,k,i) =  max(coeficientes(:));
            end
        end
    end
end

