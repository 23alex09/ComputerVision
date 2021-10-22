%Distancia entre el centroide y todos los puntos: Devuelve la distancia
%maxima, la que sacrifica un 3% de los rojos y la distancia al punto azul
%mas cercano para no meter mas ruido.

%7 valores: Los tres primeros: El centroide, Los 4 siguentes las distintas
%distancias. La primera: No perder ninguno rojo, La segunda el 3%, La
%tercera: el punto mas cercano de la otra nube y la ultima meter un poco de
%ruido
function [CentroRadios MatrizCov] = Mahalanobis(ValoresColores, CodifValoresColores)
    
    CentroideRojo = mean(ValoresColores(CodifValoresColores == 1, :));
    CentroRadios = CentroideRojo;
    
%     MCov = zeros(size(ValoresColores,2));
%     clases = unique(CodifValoresColores);
%     numClases = length(clases);
%     Matriz de covarianza de la clase de rojo fresa
%     for i = 1:numClases
%         datosOI = ValoresColores(CodifValoresColores == clases(i),:);
%         MCovClase = cov(datosOI);
%         NumDatos = size(datosOI,1);
%         MCov = MCov + NumDatos*MCovClase; %
%     end
    ValoresRojo = ValoresColores(CodifValoresColores == 1, :);
    MatrizCov = cov(ValoresRojo);
    
    %Distancia del centroide a los demas puntos de rojo fresa
    inputsOI = ValoresColores(CodifValoresColores == 1, :);
    F  = size(inputsOI,1);
    distancias = ones(F,1);
    
    for i = 1:F
        distancias(i,1) = sqrt((inputsOI(i,:)- CentroideRojo)*pinv(MatrizCov)*(inputsOI(i,:) - CentroideRojo)');
    end
    
    distancias = sort(distancias, 'descend');
    distancia3p = round(F*0.03);
    CentroRadios = [CentroRadios distancias(1) distancias(distancia3p)];
    
    %Distancia del centroide a los puntos de la nube de otro color
    inputsOI = ValoresColores(CodifValoresColores == 0, :);
    F = size(inputsOI,1);
    distancias = ones(F,1);
    
    for i = 1:F
        distancias(i,1) = sqrt((inputsOI(i,:)- CentroideRojo)*pinv(MatrizCov)*(inputsOI(i,:) - CentroideRojo)');
    end
    
    distancias = sort(distancias, 'ascend');
    distancia3p = round(F*0.03);
    CentroRadios = [CentroRadios distancias(1) distancias(distancia3p)];
    
end

