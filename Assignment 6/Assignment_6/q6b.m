% Tom Makkink
% Exercise 5.4.2 (6b)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

% Using ugrad_sim to investigate trends 
% Semester marks versus school quality and test marks for 
% a fixed Swedish point score of 30
load ugrad_train.mat

% Fix Swedish points 
x(1,:) = repmat(30,1,101);

% Vary school quality 
x(2,:) = linspace(2,10,101);

% Vary test results 
x(3,:) = [0:100];

% deploy the net 
y = ugradnet(x);

% Plots
figure 
plot(x(2,:),y(1,:));
title('Semester 1 vs School Quality');

figure 
plot(x(2,:),y(2,:));
title('Semester 2 vs School Quality');

% Plots
figure 
plot(x(3,:),y(1,:));
title('Semester 1 vs Test Score');

figure 
plot(x(3,:),y(2,:));
title('Semester 2 vs Test Score');
