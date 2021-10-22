%Funcion que devuelve la imagen umbralizada usando el metodo de otsu
function [Iu Imeds Ides] = UmbralizaLocal(I, W, const)

    I = double(I);
    W1 = W(1);
    vecindadM = ones(W1)/(W1*W1);
    medias = imfilter(I, vecindadM,'symmetric');
    umbrales = medias - const;
    Imeds = double(umbrales > I);
    
    W2 = W(2);
    desviaciones = stdfilt(I,ones(W2));
    
%     [F C] = size(desviaciones);
%     FC = floor(F/2);
%     CC = floor(C/2);
%     
%     Des1 = mat2gray(desviaciones(1:FC,1:CC));
%     Des2 = mat2gray(desviaciones(1:FC,CC+1:C));
%     Des3 = mat2gray(desviaciones(FC+1:F,1:CC));
%     Des4 = mat2gray(desviaciones(FC+1:F,CC+1:C));
    
    desviaciones = mat2gray(desviaciones);
    otsu = graythresh(desviaciones);
%     otsu1 = graythresh(Des1);
%     otsu2 = graythresh(Des2);
%     otsu3 = graythresh(Des3);
%     otsu4 = graythresh(Des4);
    
%     Ides = [ Des1>otsu1 Des2>otsu2; Des3>otsu3 Des4>otsu4];
    Ides = desviaciones>otsu;
    Iu = Imeds .* Ides;
end

