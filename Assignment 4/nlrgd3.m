function p = nlrgd3
% Non-linear regression using gradient descent 
% Steepest descent alogrithm 

clear all 
close all 
clc 

% Data points 
t = [0:10];
y = [ 0 9.38 18.67 26.14 31.8 37.68 47.35 47.92 55.49 60.82 65.62];

% rate 
% This is critical 

% a = .001 too large to converge 
a = .0001 %convergence 
% a = .00001 % Convergence 
% a = .000001 % Poor convergence 

% Initial estimate 
p(:,1) = [102; .3]';

% gradient 
g(:,1) = gr(p(:,1));

% Gradient descent updating 
for j=2:500 
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










