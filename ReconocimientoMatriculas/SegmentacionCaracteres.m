clc
clear
close all
addpath(genpath('../Trabajo Final'))
load Plantillas.mat

ListaCarac = '0123456789ABCDFGHKLNRSTXYZ';

base1 = 'Objeto';
base2 = 'Angulo';

W = 5;
sigma = W/5;
h = fspecial('gaussian', W, sigma);

Ic = imread('Test_01.jpg');
%imshow(Ic)
R = Ic(:,:,1);
Rs = imfilter(R, h, 'symmetric');
%Rs = medfilt2(R,[5 5], 'symmetric');
W = [75, 51];
const = 9;
[Iu Imeds Ides] = UmbralizaLocal(Rs, W, const);
figure, imshow(Iu)
Iu = ordfilt2(Iu,1,ones(5));
Iu = ordfilt2(Iu,25,ones(5));

figure,imshow(Iu);

Ietiq = bwlabel(Iu);


[F C] = size(Rs);

Fc = floor(F/2) + 1;
%figure, imshow(Ietiq)

objetos = unique(Ietiq(Fc,:));
caracteres = objetos(3:length(objetos));
Ib = ismember(Ietiq,caracteres);
Ib = bwareafilt(Ib, 7);
%imshow(Ib)
for i = 1:length(caracteres)
    caracter = caracteres(i);
    Ib = zeros(F,C);
    Ib(Ietiq == caracter) = 1;
    
    [a b] = find(Ib == 1);
    Fmin = min(a);
    Fmax = max(a);
    Cmin = min(b);
    Cmax = max(b);
    Ibletra = Ib(Fmin:Fmax,Cmin:Cmax);
    %figure,imshow(Ibletra)
    
    
    ncc = [];
    for j = 1:26
        ncc1 = [];
        for k = 1:7
            sentencia = ['T = ' base1 num2str(j,'%02d') base2 num2str(k,'%02d') ';'];
            eval(sentencia);
            [Fletra Cletra] = size(T);
            Ibletra = imresize(Ibletra, [Fletra Cletra]);
            coeficientes = normxcorr2(T,Ibletra);
            ncc1 = [ncc1 max(coeficientes(:))];
        end
        ncc = [ncc; ncc1];
    end
    
    [objeto angulo] = find(ncc == max(ncc(:)));
    ListaCarac(objeto)
end

