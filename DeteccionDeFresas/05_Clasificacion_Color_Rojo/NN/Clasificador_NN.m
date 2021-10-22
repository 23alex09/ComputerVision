clc
clear
close all
addpath(genpath('../../../Practica 2'))
load datos2.mat


%NN: codificacion = sim(net, input) net es una red ya entrenada las
%caracteristicas van en las filas 
%Diseño:
%   Trasponemos los valores de entrada de todas las muestras que tenga
%   Crear vector fila con las codificaciones de salida (1 2 3 4)
%   Ponemos en el vector la codificacion segun corresponda
%   NeuronasCapaEntrada = numero caracteristicas que usamos
%   Capa oculta = dos de 15
%   Capas de la red es una matriz fila con el numero de neuronas de cada
%   capa sin contar la de salida
%   net = feedforwardnet(CapasRed)
%   view(net)
%   numCpas = length(Capas) +1

RGB = VCN(:,1:3)';
RSL = VCN(:,[1 5 10])';
Lab = VCN(:,10:12)';

CodifValoresColores(CodifValoresColores ~= 255) = 0;
CodifValoresColores(CodifValoresColores == 255) = 1;

netRGB = Calcula_NN(RGB, CodifValoresColores');
netRSL = Calcula_NN(RSL, CodifValoresColores');
netLab = Calcula_NN(Lab, CodifValoresColores');

save nets.mat netRGB netRSL netLab

