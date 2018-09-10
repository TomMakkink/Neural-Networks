% Tom Makkink
% Exercise 7.6.3 (5)
% Cancer problem with RBE
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
% Replaced all missing data by 3.5
Data = importdata('cancerdata_fixed.txt');
P = Data(:, [2:10]);
T = Data(:, [11]);

% Organise patterns and targets 
p = P';
t = T';

% Change 2 (benign) to 1 and 4(malignant) to -1
t(t==2)=1;
t(t==4)=-1;

%%
%---------------------------------------------------------------------
% Divide training and test sets by index 
%----------------------------------------------------------------------

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
sr = [1,10];

%%
%---------------------------------------------------------------------
% Find the best Spread
%----------------------------------------------------------------------
% Use this procedure to find the best spread:
% matrix for storing spread and r 
R = [];
for s=linspace(sr(1),sr(2),200)
    %train on training set 
    net = newrbe(ptrain,ttrain,s);
    % simulate on test set 
    a = sim(net,ptest);
    [r2,r] = correlation(a,ttest);
    r2
    R = [R;[s r2 r]];
end
disp('   spread      r2       r');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R');

% Find the best spread wrt r2 stat 
[mr2,i] = max(R(:,2));
bs2 = R(i,1);

% Find the best spread wrt r: correlation coeff 
[mrl,j] = max(R(:,3));
bs = R(j,1);

%%
%---------------------------------------------------------------------
% Simulate with the best spread
%----------------------------------------------------------------------
net = newrbe (ptrain,ttrain,bs2);
atrain = sim(net,ptrain);
atest = sim(net,ptest);

disp('Training set: ')
[r2train rtrain] = correlation(atrain,ttrain)

disp('Test set: ')
[r2test rtest] = correlation(atest,ttest)

%%
%---------------------------------------------------------------------
% Access accuracy 
%----------------------------------------------------------------------
% Make diagnosis 
atest = hardlim(atest);

% Find accuracy 
% Number correct 
nc = sum(atest==ttest);

% Percentage correct 
pc = nc/length(ttest)*100;

fprintf('percentage accuracy is %5.2f\n',pc);











