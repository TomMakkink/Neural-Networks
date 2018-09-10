% housingv2_train
clear
close all
clc 

load housing.mat
[r,q] = size(p)
% network architecture 
% neurons in layers 1,2 
s1 = 10;
s2 = 8;

% Create the net 
net = feedforwardnet ([s1,s2]);
%display(net)

% training 
net.trainFcn = 'trainscg';

%maxit 
net.trainParam.epochs = 1000;

% number of epochs that the error on the validation set increases
net.trainParam.max_fail = 20;

% Set the ratios
%We can also set using:
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

% Initiate 
net = init(net);

% train
[net,netstruct] = train(net,p,t);

% name the net and the structure 
net.userdata = 'Housing'
housingnet = net;
housingstruct = netstruct;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1 = size(ptrain,2);
q2 = size(ptest,2);

%simulate
atrain=sim(housingnet,ptrain); %train
atest=sim(housingnet,ptest); %test
a=sim(housingnet,p); %all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%assessing the degree of fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples \n',q))
disp('train')
disp('activation target')
M=[atrain ;ttrain];
fprintf('%4.1f\t\t\t%4.1f\n',M)
%-------------------------------------------------------------

%test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples \n',q))
disp('test')
disp('activation target')
M=[atest ;ttest];
fprintf('%4.1f\t\t\t%4.1f\n',M)
%-------------------------------------------------
%all
r2=rsq(t,a);
[R,PV]=corrcoef(t,a);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(t,t,t,a,'*')
title(sprintf('Testing: With %g samples \n',q))
disp('all')
disp('activation target')
M=[a ;t];
fprintf('%4.1f\t\t\t%4.1f\n',M)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MATLAB post regression functions
r=postreg(a,t);
rtest=postreg(atest,ttest);
rtrain=postreg(atrain,ttrain);
disp('MATLAB postregression')
disp('-----------------------')
fprintf('train r=%g\n',rtrain)
fprintf('test r=%g\n',rtest)
fprintf('all r=%g\n',r)
%plot errors on a histogram
e=t-a;
hist(e)
title('all errors')
xlabel('errors')
ylabel('instances')
%MATLAB regression plotting functions:
plotregression(ttest,atest)
title('test')
plotregression(t,a)
title('train')
plotregression(t,a)
title('all')
%MATLAB performanc3 plots
%plotperform(netstruct)
%save all variables
save housing_train.mat



