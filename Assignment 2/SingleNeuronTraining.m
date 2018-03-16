% Tom Makkink
% Single Neuron Training
% Finding a suitable W and b
%---------------------------------------------------------------------------
clc
clear
close all

% Input pattern to be classified 
P = [1 -1 0; 2 2 -1];
T = [1 0 0];
W = [1 -1];
b = .1;
N = W*P + b;
A = hardlim(N);

p1 = P(:,1);
W = W + p1';
b = b+1;
a1 = hardlim(W*p1 + b)

% Move so the third A matches with the third target
p3=P(:,3);
W = W-p3';
b = b-1;

a3 = hardlim(W * p3 + b)









