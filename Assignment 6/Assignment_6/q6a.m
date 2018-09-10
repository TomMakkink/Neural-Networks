% Tom Makkink
% Exercise 5.4.2 (6a)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

% Using ugrad_sim to investigate trends 
% Semester marks versus school quality and Swedish points 
% for a fixed test mark of 50
load ugrad_train.mat

% Vary Swedish points 
x(1,:) = linspace(20,46,91);

% Vary school quality 
x(2,:) = linspace(2,10,91);

% Fix test results 
x(3,:) = repmat(50,1,91);

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
plot(x(1,:),y(1,:));
title('Semester 1 vs Swedish Points');

figure 
plot(x(1,:),y(2,:));
title('Semester 2 vs Swedish Points');










