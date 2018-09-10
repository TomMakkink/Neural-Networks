% XOR problem taken from book 

clc 
clear

% Patterns and targets 
p = [1 1 0 0; 1 0 1 0];
t = [0 1 1 0];

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
plot(1,1,'o')
plot(0,0,'o')
plot(1,0,'*')
plot(0,1,'*')
hold off 









