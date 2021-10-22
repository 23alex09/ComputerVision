function [If] = FiltroAdaptativoV2(I, H, VarRuido, relleno)
    [N M] = size(I);
    Nv = H(1);
    Mv = H(2);
    vecindad = ones(Nv,Mv);
    I = double(I);
    VarLocal = stdfilt(I, vecindad).^2;
    mascara = vecindad/(H(1)*H(2));
    MediaL = imfilter(I, mascara, relleno);
    If = I - (VarRuido./VarLocal).*(I-MediaL);    
    If = uint8(If);
end

