%% Tom Makkink
% Body Fat Estimation Problem 
% Body_fat_test
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Load the data and set up training indices 
%----------------------------------------------------------------------
load bodyFat.mat

% Training set
ttrain=t(:,tr.trainInd);
ptrain=p(:,tr.trainInd);
atrain=sim(bodyFatNet,ptrain);

% Test set
ttest=t(:,tr.testInd);
ptest=p(:,tr.testInd);
atest=sim(bodyFatNet,ptest);

% Validation set
tval=t(:,tr.valInd);
pval=p(:,tr.valInd);
aval=sim(bodyFatNet,pval);


%%
%----------------------------------------------------------------------
% Access performance
%----------------------------------------------------------------------
[r2train Rtrain]= correlation(atrain, ttrain)
[r2test Rtest]=correlation(atest,ttest)

% Compare:
[atrain' ttrain'];

% Compare
[atest' ttest'];

%plotconfusion(at,tt)
