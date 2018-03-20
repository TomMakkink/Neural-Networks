% Tom Makkink
% Exercise 4.8.3 (1)
% Performance surfaces  
%---------------------------------------------------------------------------
clear all
close all
clc

% Data 
t= [0:10];
y= [0 2.67 -2.32 -0.80 2.98 -1.55 -1.61 2.83 -0.86 -2.35 2.87];

% rate 
a = .0001 %convergence 

% Initial estimate 
p(:,1) = [3.3; 2.2]';

% gradient 
g(:,1) = gr(p(:,1));

% Gradient descent updating 
for j=2:50 
    p(:,j) = p(:,j-1)-a*g(:,j-1);
    g(:,j) = gr(p(:,j));
    %pause 
end 

M = p(1,end);
k = p(2,end);

fprintf('M=%g k=%g\n', M, k);

figure 
plot(p(1,:),p(2,:),'x');
xlabel('M values');
ylabel('k values');

figure 
plot(t,y,'o');
hold on 
tt = linspace(0,10,101);
yy = rf(tt,M,k);
plot(tt,yy);
title(sprintf('Regression by GD:\n Regr fnc: y = M(1-exp(-kt))\n with M = %g k= %g\n', M, k));
xlabel('t');
ylabel('y');