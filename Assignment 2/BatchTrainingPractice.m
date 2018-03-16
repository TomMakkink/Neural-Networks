% Tom Makkink
% Batch Training the Perceptron
% Finding a suitable W and b
%---------------------------------------------------------------------------
clc
clear
close all

% Input pattern to be classified 
P = [-2 1 3 4; 2 1 -2 3];
T = [1 0 0 1];
W = [-.1 .2];
b =.2;
N = W*P+b;
A = hardlim(N);
E = T-A;
Q =P';
dW = E*P';
db =sum(E);
W = W + dW;
b = b + db