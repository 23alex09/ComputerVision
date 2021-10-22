%Funcion que aplica un filtro de la mediana sobre la imagen
function [If] = filtraImagen(I)
    W = 5;
%     sigma = W/5;
%     h = fspecial('gaussian', W, sigma);
    %If = imfilter(I, h, 'symmetric');
    If = medfilt2(I,[W W], 'symmetric');
end

