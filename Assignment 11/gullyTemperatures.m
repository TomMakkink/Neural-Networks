% Tom Makkink
% Sliding Window Approach 
% Gully Temperatures 
%---------------------------------------------------------------------------

clc 
clear all
close all 

%% Read in and view the data 
x = xlsread('Temperatures',1,'d2:d1874');

% View the data 
figure 
plot(x)
xlabel('time peroids')
ylabel('temperature') 

%% 
% produces a moving window of length r from the sequence x
[p,t] = delay(x',150)
q = size(p,2);

% Size of the test set 
n = 150;

% q-n n
%<---train---->      <----test--->
%1,2,.........q-n,    q-n+1, ... q

%ttest index 
ti = [q-n+1:q];

% Training index 
tri = [1:q-n];

% Test set: last n 
ptest = p(:,ti);
ttest = t(:,ti);

% Train set 
ptrain = p(:,tri);
ttrain = t(:,tri);

net.dividefcn='divideind';
net.divideparam.trainind=tri;
net.divideparam.testind=ti;

s1=10;
s2=10;

% Network architecture 
net = feedforwardnet([s1,s2]);

% Net training 
net.TrainParam.epochs = 1000;
% Training 
net.trainFcn = 'trainscg';

% Initiate the weights and biases 
net = init(net);

% Train the net 
[net, netstr] = train(net, ptrain, ttrain);

% Rename 
gullynet = net;

% Activations 
atrain = sim(net, ptrain);
atest = sim(net, ptest);
a = sim(net, p);

% Degree of fit 
r2 = correlation(atest,ttest)
[R,pv] = corrcoef(ttest,atest)

figure 
plot(ttest,ttest,ttest,atest,'.')
title('test');

figure 
hold on
plot([1:length(atest)],ttest,'o')
plot([1:length(atest)],atest,'.')
hold off
title(sprintf('activation on test set'))
figure
plot([1:length(a)],a,[1:length(a)],t,'o')
title('activalion on all')
save gully.mat
















