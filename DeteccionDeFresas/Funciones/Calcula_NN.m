%Las caracteristicas en fila y cada instancia en una columna

function [net] = Calcula_NN(inputs,outputs)
    [NeuronasEntrada temp] = size(inputs);

    NeuronasCapaOculta1 = 15;
    NeuronasCapaOculta2 = 15;

    CapasRed = [NeuronasEntrada NeuronasCapaOculta1 NeuronasCapaOculta2];
    
    net = feedforwardnet(CapasRed);
    net.trainParam.epochs = 500;
    
    net = train(net,inputs,outputs);
end

