% Tom Makkink
% Exercise 6.1.3 (2)
% Crab Classification Problem 
%---------------------------------------------------------------------------

clc 
clear all
close all 

[p,t] = crab_dataset;
[r,q] = size(p);
setdemorandstream(491218382);
% Create the net 
net = feedforwardnet ([10,2]);
%net = feedforwardnet ([9,2]);

% train 
[net,netstruct] = train(net,p,t);

% name the net and the structure 
net.userdata = 'crab';
crabnet = net;
crabstruct = netstruct;

% % Set the ratios
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);
 

% Simulate the network
atrain = sim(crabnet,ptrain);   % train
atest = sim(crabnet,ptest);     % test
a = sim(crabnet,p);             % all

%--------------------------------------------------------------------------
% Accessing degree of fit
%--------------------------------------------------------------------------

r2train = rsq(ttrain,atrain)
r2test = rsq(ttest,atest)
r2all = rsq(t,a)

plotconfusion(ttest,atest);

[c,cm] = confusion(ttest,atest)

fprintf('Percentage Correct Classification   : %3.2f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %3.2f%%\n', 100*c);


