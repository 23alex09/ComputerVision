clc
clear
close all
addpath(genpath('../Trabajo Final'))


numCaracteres = [7,6,7,7,7,7,7,6,6,6,7,7,7,7,7,7,7,7,7,6];

for i = 1:20
    I = imread(['Test_' num2str(i,'%02d') '.jpg']);
    res = reconoceMatricula(I,numCaracteres(i));
    title(res)
end