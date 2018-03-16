% Tom Makkink
% Multiple Neuron Perceptrons
% Finding a suitable W and b
%---------------------------------------------------------------------------
clc
clear
close all

% Input pattern to be classified 
P = [ 1 2 3 4; 7 2 3 4; 4 6 3 2];
T = [ 1 2 1 2; 4 3 5 6]
W = [1 -1 1; 1 2 5]
b = [2 ; 3]

B = repmat(b,1, size(P,2));

%This is neccessary otherwise we cannot form W*P+b
N = W*P+B;
A = hardlim(N);
E = T - A;
dW = E*P';
dB = sum(E,2);

% For an augmented matrix
% Pa =[P;ones(1,size(P,2))];
% Wa = [W b];
% A = hardlim(Wa*Pa);
% E = T-A;
% dWa = E * Pa'
