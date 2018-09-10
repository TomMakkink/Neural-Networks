% Tom Makkink
% Exercise 5.4.2 (9)
% Batch Training 
%---------------------------------------------------------------------------
clear all 
close all 
clc 
load risk_train.mat

% Use Data provided 
x = [.6; .8; .5; .1]; 

% deploy the net 
y = risknet(x);

fprintf('Risk: %g\n', y);
