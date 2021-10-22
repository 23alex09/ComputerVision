function [modeloSVM] = Calcula_SVM(inputs,outputs)
    modeloSVM = fitcsvm(inputs, outputs);
    modeloSVM = compact(modeloSVM);
end

