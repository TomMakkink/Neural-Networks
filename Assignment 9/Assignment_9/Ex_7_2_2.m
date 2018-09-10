% Tom Makkink
% Exercise 7.2.2
% Radial Basis Functions 
%---------------------------------------------------------------------------

clc 
clear all
close all 

% generate the data 
p = [0;0.5;1.0;1.5;2;2.5;3.0];
t = [0;0.3894;0.6065;0.7085;0.7358;0.7163;0.6694];

% spread and bias 
s = 1;
b = sqrt(log(2))/s;

% compute the radial basis function F:
for j=1:length(p)
    n = b*abs((p-p(j)));
    F(:,j)=exp(-n.^2);
end 
% show F 
F

% Solve for C 
c = F\t

% activation on data points 
a=F*c;

% compare:
[t a]

% plot:
x = linspace(0, 2*pi, 101)';
for j=1:length(p)
    n=b*abs((x-p(j)));
    FF(:,j)=exp(-n.^2);
end

% activation on x 
y = FF*c;

% Plot to compare 
close all 
hold on 
plot(x,y)
plot(p,t,'o')
plot(p,a,'*')
plot([0;2*pi],[0;0])
hold off 
title(sprintf('Interpolation with RBFs s=%5.4f\n',s))


