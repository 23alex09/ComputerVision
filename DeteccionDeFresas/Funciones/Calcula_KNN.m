function [ModeloKNN] = Calcula_KNN(inputs,outputs, numVecinos)
    ModeloKNN= fitcknn(inputs, outputs, 'NumNeighbors', numVecinos);
end

