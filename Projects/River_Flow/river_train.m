%% Tom Makkink
% River flow prediction 
% river_flow
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
% Read in the data 
p = river_dataset;

%days list 
m = length(p);
r = 24;
c = cell2mat(p);

plot(c) 
title('River Flow') 
xlabel('Month')
ylabel('Flow')

%size of test set: the last n
n=24;

%ttest index
ti=[m-n:m];

%training index
tri=[1:m-n-1];
ptrain=p(tri);
net=newfftd(ptrain,ptrain,[1:r],[20, 20]);

%set goal>0 since there is no validation set
net.trainParam.goal=1e-2;
net=init(net);

%initial inputs which have no targets
pi=p([1:r]);

%train the net
net=train(net,ptrain,ptrain,pi);

%rename
rivernet = net;
save riverNet.mat





