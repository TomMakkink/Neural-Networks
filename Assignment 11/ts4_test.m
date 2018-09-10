% Tom Makkink
% Exercise 8.2.6
% ts4_test
%---------------------------------------------------------------------------
load ts4.mat 

clc;
close; 

%simulate on all input cells
%produces cell output
%use values in ptraini as initial conditions
ac=sim(ts4net,p,pi)

%convert to vectors
a=cell2mat(ac)

%compare
[a(:) x(:)]

t=x;

%calculating r2:
%means of the feature rows
mt=repmat(mean(t,2),1,size(t,2));

%sum of squares error between activations and targets
ss=sum((a-t).^2,2);

%sum of squares error between mean of targets and targets
ssm=sum((mt-t).^2,2);

%row vector of the r2 stats of the columns
r2=1-ss./ssm;
atest=a(ti);
xtest=x(ti);

r2test=rsq(xtest,atest)

figure
plot(xtest,xtest,xtest,atest,'*')
title(sprintf('test r2test = %5.4f\n',r2test))
