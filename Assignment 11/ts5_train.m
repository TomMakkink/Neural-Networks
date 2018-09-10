% Tom Makkink
% Exercise 8.2.6
% Dynamic Neural Networks 
%---------------------------------------------------------------------------
%ts3_train
close all; 
clc; 
clear;

load ts1seq_mod.mat

%x(i) depends on two previous: x(i-1), x(i-2)
%so initial delay, id =[1 2]
%net is not trained on x(1), x(2) and there are no targets for x(1),x(2)

%r=length of initial delay vector
r=2;

%obtain sequential inputs
p=con2seq(x);
q=size(x,2);

%size of test set: the last n
n=10;

%training index
tri=[1:q-n];

%train set
ptrain=p(:,tri);

%ttest index
ti=[q-n+1:q];

%test set: last n
net=newfftd(ptrain,ptrain,[1:r],[2, 2 ]);

%note that the default is trainlm
%works much better than trainscg
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
ts5net=net;
save ts5.mat
