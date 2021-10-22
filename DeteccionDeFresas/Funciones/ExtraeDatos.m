function [datos] = ExtraeDatos(Im)
        R = Im(:,:,1);
        G = Im(:,:,2);
        B = Im(:,:,3);
        
        RN = double(R)/255;
        GN = double(G)/255;
        BN = double(B)/255;
        
        %HSI
        %Los valores que devuelve esta funcion ya estan normalizados entre
        %0 y 1
        hsv = rgb2hsv(Im);
        
        H = hsv(:,:,1);
        S = hsv(:,:,2);
        %Para la I hacemos la media de cada uno de los canales de color
        %para cada pixel
        rgbN = cat(3, RN, GN, BN);
        I = mean(rgbN,3);
        
        %YUV
        %Hay que usar los datos de RGB ya normalizados
        Y = 0.299*RN + 0.587*GN + 0.114*BN;%Ya esta normalizado
        U = 0.492*(BN-Y);
        V = 0.877*(RN-Y);
        
        UN = mat2gray(U, [-0.6 0.6]);
        VN = mat2gray(V, [-0.6 0.6]);
        %Lab
        %Estos valores hay que normalizarlos segun sus rangos de valores
        Lab = rgb2lab(Im);
        L = Lab(:,:,1);%Valores de 0 a 100
        a = Lab(:,:,2);%Valores de -128 a 127
        b = Lab(:,:,3);%Valores de -128 a 127
        
        LN = L/100;
        aN = mat2gray(a,[-128 127]);
        bN = mat2gray(b,[-128 127]);
        
        datos = [RN(:) GN(:) BN(:) H(:) S(:) I(:) Y(:) UN(:) VN(:) LN(:) aN(:) bN(:)];
end

