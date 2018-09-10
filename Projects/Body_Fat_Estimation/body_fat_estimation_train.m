%% Tom Makkink
% Body Fat Estimation Problem 
% Body_fat_train
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Load the data and set up training indices 
%----------------------------------------------------------------------
% Import the data
[p,t] = bodyfat_dataset;

m=size(p,2);

%%
%----------------------------------------------------------------------
% Set up and propagate the network 
%----------------------------------------------------------------------
% Number of neurons in hidden layers
s1 = 20;
s2 = 20; 

% Set up net
net = fitnet([s1, s2], 'trainbr'); 

% Set maximum number of epochs 
net.trainParam.epochs = 500;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';

[net, tr] = train(net, p, t);

%%
%----------------------------------------------------------------------
% Plot, rename and save the net
%----------------------------------------------------------------------
% Plot the performance 
plotperform(tr);

% Rename 
bodyFatNet = net;

% Save 
save bodyFat.mat 












