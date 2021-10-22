function [HRecalculado] = RecalculaH(H)
    
    L = length(H);
    for i = 1:L
        if H(i) <= 0.5
            HRecalculado(i) = 1 - (2*H(i));
        end
        if H(i) > 0.5
            HRecalculado(i) = 2*(H(i)-0.5);   
        end
    end
end

