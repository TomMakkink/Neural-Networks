% School problem with radial basis network 

clc 
clear
close all 

% Import the data 
Data = importdata('school.txt');
p = Data(:,[1 2]);
t = Data(:,3);

% Arrange as rows 
p = p';
t = t';

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
sr = [.1,6];

% Use this procedure to find the best spread:
% matrix for storing spread and r 
R = [];
for s=linspace(sr(1),sr(2),11)
    %train on training set 
    net = newrbe(ptrain,ttrain,s);
    % simulate on test set 
    a = sim(net,ptest);
    [r2,r] = correlation(a,ttest);
    r2
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

% Simulate with best spread 
net = newrbe (ptrain,ttrain,bs2);
atest = sim(net,ptest);
[r2 r] = correlation(atest,ttest)

t = ttest;
a = atest;

% Plot 
figure 
hold on 
plot(t,t)
plot(t,a,'*')
hold off 
title(sprintf('schoolrbe with spread %4.2f\n',bs))
xlabel('targets')
ylabel('activation')


















