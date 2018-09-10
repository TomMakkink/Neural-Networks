%% Tom Makkink
% Cancer Classification Problem 
% Cancer_train
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Load the data and set up training indices 
%----------------------------------------------------------------------
load cancer.mat

% Training set
ttrain=t(:,tr.trainInd);
ptrain=p(:,tr.trainInd);
atrain=sim(cancerNet,ptrain);

% Test set
ttest=t(:,tr.testInd);
ptest=p(:,tr.testInd);
atest=sim(cancerNet,ptest);

% Validation set
tval=t(:,tr.valInd);
pval=p(:,tr.valInd);
aval=sim(cancerNet,pval);


%%
%----------------------------------------------------------------------
% Access performance and plot
%----------------------------------------------------------------------
[r2train Rtrain]= correlation(atrain, ttrain)
[r2test Rtest]=correlation(atest,ttest)

% Compare:
[atrain' ttrain'];

% Compare
[atest' ttest'];

% Make diagnosis
atest=hardlims(atest);
[atest' ttest'];

%find accuracy
%number correct
nc=sum(atest==ttest);

%percentage correct
pc=nc/length(ttest)*100;

fprintf('percentage accuracy is %5.2f\n',pc)

at=(atest+1)/2;
tt=(ttest+1)/2;

plotconfusion(at,tt)













