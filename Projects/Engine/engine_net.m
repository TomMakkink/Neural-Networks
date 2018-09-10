%% Tom Makkink
% Engine fitting Network 
% Engine_net
%---------------------------------------------------------------------------

clear all
close all 
clc 

%%
%----------------------------------------------------------------------
% Load the data 
%----------------------------------------------------------------------
[p,t] = engine_dataset; 
[r,q] = size(p); 

%%
%----------------------------------------------------------------------
% Network Architecture 
%----------------------------------------------------------------------
% Number of neurons in each layer 
s1 = 20; 
s2 = 20;

% create network
net=feedforwardnet([s1,s2]);

% training,testing and validation sets
[ptrain,pval,ptest,trainInd,valInd,testInd]=dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

% train
[net,netstruct] = train(net,p,t);

% name network and structure
net.userdata = 'engine';
engineNet    = net;
engineStruct = struct;

%%
%----------------------------------------------------------------------
% Simulate on the network 
%----------------------------------------------------------------------
% Number of elemnets in training and test set
q1 = size(ptrain, 2); 
q2 = size(ptest, 2); 

atrain = sim(engineNet, ptrain);;
atest  = sim(engineNet, ptest); 
a      = sim(engineNet, p); 


%%
%----------------------------------------------------------------------
% Access degree of best fit 
%----------------------------------------------------------------------
%train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);

fprintf('Training:\n\n')
fprintf(' corr coeff: [%g, %g, %g, %g]\n p value: [%g, %g, %g, %g]\n r2: %g, %g\n',R,PV,r2)
disp('----------------------------------------------------------------------')

figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n',q1))
%-------------------------------------------------------------

%test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);

fprintf('Testing:\n\n')
fprintf(' corr coeff: [%g, %g, %g, %g]\n p value: [%g, %g, %g, %g]\n r2: %g, %g\n',R,PV,r2)
disp('----------------------------------------------------------------------')

figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples \n',q2))
%-------------------------------------------------
%all
r2=rsq(t,a);
[R,PV]=corrcoef(t,a);
fprintf('Testing (all inputs):\n\n')
fprintf(' corr coeff: [%g, %g, %g, %g]\n p value: [%g, %g, %g, %g]\n r2: %g, %g\n',R,PV,r2)
disp('----------------------------------------------------------------------')
figure
plot(t,t,t,a,'*')
title(sprintf('Testing on all inputs: With %g samples \n',q))

%% save variables 

save engine.mat engineNet 



































