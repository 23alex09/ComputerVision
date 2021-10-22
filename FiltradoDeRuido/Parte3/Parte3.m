clc
clear
close all
addpath(genpath('../../Practica 4'))

I = imread('P4.tif');
desviaciones = [5 10 35];
medias = [0 0 0];
vecindades = [3 7];
MatrizEficiencia = [];
for i = 1:length(desviaciones)
    Ir = RuidoGaussiano(I, medias(i), desviaciones(i));
    
    for j = 1:length(vecindades)
        figure('Name',['Deviacion: ' num2str(desviaciones(i)) ' Vecindad: ' num2str(vecindades(j))],'NumberTitle','off')        
        subplot(2,2,1)       
        imshow(Ir)
        title('Imagen Ruidosa')
        %Filtro Gaussiano
        h = fspecial('gaussian', vecindades(j), vecindades(j)/5);
        Ifg = imfilter(Ir, h, 'symmetric');
        Eg = Eficiencia(I,Ir,Ifg);
        subplot(2,2,2)     
        imshow(Ifg)
        title('Filtro Gaussiano')
        %Filtro de la Mediana
        Ifm = medfilt2(Ir, [vecindades(j) vecindades(j)], 'symmetric');
        Em = Eficiencia(I,Ir,Ifm);
        subplot(2,2,3)
        imshow(Ifm)
        title('Filtro de la Mediana')
        %Filtro Adaptativo
        Ruido = double(I) - double(Ir);
        VarRuido = std(Ruido(:))^2;
        Ifa = FiltroAdaptativoV2(Ir, [vecindades(j) vecindades(j)], VarRuido, 'symmetric');
        Ea = Eficiencia(I,Ir,Ifa);
        subplot(2,2,4)
        imshow(Ifa)
        title('Filtro Adaptativo')
        
        MatrizEficiencia = [MatrizEficiencia; desviaciones(i) vecindades(j) Eg Em Ea];
    end 
end