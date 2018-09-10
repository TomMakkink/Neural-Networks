% Tom Makkink
% Exercise 7.6.3 (2)
% TwoClass
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
%   x x x 
%   x o x
%   x x x

p = [0 0 0 1 1 1 2 2 2;0 1 2 0 1 2 0 1 2]
t = [1 1 1 1 0 1 1 1 1]

% rbf net
net = newrbe(p,t,.5);

% Input for simulation 
n=51;
x = linspace(-3,3,n);

% simulate on values in x 
[X,Y] = meshgrid(x,x);
XX = X(:)';
YY=Y(:)';
P = [XX;YY];
A = sim(net,P)
z = reshape(A,n,n)

close all 
surf(x,x,z)

figure 
hold on 
contour(x,x,z)
plot(p(1,t==1),p(2,t==1),'X')
plot(p(1,t==0),p(2,t==0),'O')
hold off 




















