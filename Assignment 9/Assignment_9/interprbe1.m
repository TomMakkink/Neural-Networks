% Tom Makkink
% Exercise 7.6.3 (1)
% Interprbe1 
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
% Import the data 
Data = importdata('interprbe1data.txt');
p = Data(1,:)
t = Data(2,:)

% Test index 
m = size(p,2);
I = randperm(m);
ti = I(1:floor(m/5));

% Training index 
tri = setdiff([1:m],ti);

% Training and test sets 
ptrain = p(:,tri);
ttrain = t(:,tri);
ptest = p(:,ti);
ttest = t(:,ti);

d = dist(p',p);
dm = max(max(d));
fprintf('max distance between inputs = %4.2f\n',dm)

% sr = input('spread range = [min, max] = ')
sr = [.1,80];


%% 
%----------------------------------------------------------------------
% Find the best spread
%----------------------------------------------------------------------
% Procedure to find the best spread:
% matrix for storing spread and r 
R = [];
for s=linspace(sr(1),sr(2),80)
    %train on training set 
    net = newrbe(ptrain,ttrain,s);
    % simulate on test set 
    a = sim(net,ptest);
    [r2,r] = correlation(a,ttest);
    R = [R;[s r2 r]];
end
disp('   spread      r2       r');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R')

% Find the best spread wrt r2 stat 
[mr2,i] = max(R(:,2));
bs2 = R(i,1);

% Find the best spread wrt r: correlation coeff 
[mrl,j] = max(R(:,3));
bs = R(j,1);

%% 
%----------------------------------------------------------------------
% Simulate with best spread 
%---------------------------------------------------------------------- 
net = newrbe (ptrain,ttrain,bs2);
atest = sim(net,ptest);
[r2 r] = correlation(atest,ttest)

% Simpulate on linspace(0,10,101)
X = linspace(0,10,101);
Y = sim(net,X);

% Simulate at p = 6
Y6 = sim(net,6);
fprintf("The missing data point is: %4.2f\n", Y6);%4.2f\n',dm)


%% 
%----------------------------------------------------------------------
% Plot
%---------------------------------------------------------------------- 

% Plot 
figure 
hold on 
plot(X,Y)
plot(p,t,'o')
plot(6,Y6,'*')
hold off 
title(sprintf('schoolrbe with spread %4.2f\n',bs))
xlabel('targets')
ylabel('activation')













