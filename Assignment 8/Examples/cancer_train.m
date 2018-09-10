%% Tom Makkink
% Cancer Classification Problem 
% Cancer_train
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
%load data
% There are 9 input attributes, all discrete on a scale 1 - 10 (integer)
% and 1 binary output attribute (2=benign, 4=malignant).
% This encoding is used directly, except that the values are scaled
% to a 0...1 range and that the output is represented with two units.
% There are 16 missing values for attribute 6; they are encoded as 0.3 since
% the average value of that attribute is rougly 3.5.
%
% Class distribution:
% Class benign malign total
% ---------------------------------------
% total # 458   241    699
% total % 66    34     100

% Import the data 
D = importdata('cancerdata.txt');

% Import patterns and Targets 
p=xlsread('cancerdata.xls','B4:J702');
t=xlsread('cancerdata.xls','K4:K702');

% Organise data 
p = p';
t = t';

%change 2(benign) to 1 and 4(malignant) to -1
t(t==2)=1;
t(t==4)=-1;
m=size(p,2);

%%
%----------------------------------------------------------------------
% Set up and propagate the network 
%----------------------------------------------------------------------

% Number of neurons in each layer 
s1 = 50;
s2 = 50;

% Deploy the net
net = feedforwardnet([s1,s2]);

% Display net 
display(net);

% Set training ratios 
%[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
%[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

net = init(net);
[net,tr] = train(net, p, t);

%%
%----------------------------------------------------------------------
% Plot, rename and save the net
%----------------------------------------------------------------------
% Plot the performance 
plotperform(tr);

% Rename 
cancerNet = net;

% Save 
save cancer.mat 







