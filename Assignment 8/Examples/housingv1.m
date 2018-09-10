% housingv1
% Default settings 
clear 
close all
clc 

load housing.mat

% Network architecture 
% Neurons in layers 1,2
s1 = 10;
s2 = 8;

% Create the net 
net = feedforwardnet ([s1,s2]);


% train 
[net,netstruct] = train(net,p,t);