% Tom Makkink 
% Ex 1.1.4 5 in Neural Networks Notes 

function r=r2(a,t)
%function r=r2(a,t)
%Finds the R^2 statistic for 
%a: activation vector
%t: target vector
clear
clc
clf
a=0:10;
t =[5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899];

%calculating r2:
% calculate the average of an input vector t
% and return a two dimensional output
tbar=mean(t,2);
% Create an array of the same length as t, which contains 
% the mean values
tBar=repmat(tbar,1,length(t));
% ||a-t||^2 
ss=sum((a-t).^2,2)/length(t);
% ||a-tbar||^2
sstB=sum((tBar-t).^2,2)/length(t);
r2v=1-ss./sstB;
r=mean(r2v);