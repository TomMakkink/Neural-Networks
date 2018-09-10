% ugrad_sim 
% Deploys ugradnet to investiagte trends 

clear all 
close all 
clc 
load ugrad_train.mat

% Vary Swedish points 
x(1,:) = linspace(24,46,91);

% Fix school quality 
x(2,:) = repmat(5,1,91);

%Vary test results 
x(3,:) = [0:100];

% deploy the net 
y = ugradnet(x);

% Plots
figure 
plot(x(3,:),y(1,:));
title('Semester 1 vs test marks');

figure 
plot(x(3,:),y(2,:));
title('Semester 2 vs test marks');

% Plots
figure 
plot(x(1,:),y(1,:));
title('Semester 1 vs Swedish Points');

figure 
plot(x(1,:),y(2,:));
title('Semester 2 vs Swedish Points');