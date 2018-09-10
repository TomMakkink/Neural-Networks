% Tom Makkink
% Exercise 8.2.6
% ts4_train
%---------------------------------------------------------------------------

clc 
clear all
close all 

% Load and organise data
load delay3.mat

% r = length of initial delay vector 
r = 8; 

% Size of the test set: the last n
n = 10; 

%obtain sequential inputs
p=con2seq(x);

q=size(x,2);

%training index
tri=[1:q-n];

%train set
ptrain=p(:,tri);

%ttest index
ti=[q-n+1:q];

net=newfftd(ptrain,ptrain,[1:r],[2, 2 ]);

net.dividefcn='divideind';
net.divideparam.trainind=tri;
net.divideparam.testind=ti;
net.divideparam.valind=[];

%set goal>0 since there is no validation set
net.trainParam.goal=1e-8;

net=init(net);

%initial inputs which have no targets
pi=p([1:r]);

%train the net
net=train(net,ptrain,ptrain,pi);

%rename
ts4net=net;

save ts4.mat








