% Tom Makkink
% Exercise 5.4.2 (6c)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

% Using ugrad_sim to investigate trends 
% If a student comes from a school of quality 6 and has 
% Swedish point score of 25, find the test
% mark that should be obtained to pass both semesters.
load ugrad_train.mat

% Fix Swedish points 
x(1,:) = repmat(25,1,101);

% Fix school quality 
x(2,:) = repmat(6,1,101);

% Vary test results 
x(3,:) = [0:100];

% deploy the net 
y = ugradnet(x);

% Plots
figure 
plot(x(3,:),y(1,:));
title('Semester 1 vs Test Score');

figure 
plot(x(3,:),y(2,:));
title('Semester 2 vs Test Score');

disp('They would need a test score of 10% to pass both semesters.');
