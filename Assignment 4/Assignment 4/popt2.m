% Tom Makkink
% Exercise 4.8.3 (1)
% Performance surfaces  
%---------------------------------------------------------------------------

clear all
close all
clc

x1 = [-1:.01:1];
x2 = x1;
[X1, X2]=meshgrid(x1,x2);

% Function 
z = (X1.^2) + (X1.*X2) + (X2.^2);

% Prompt user for intial starting point 
p(:,1) = input('First point [x,y] where -1<x<1 and -1<y<1 = ');

% Hessian Matrix 
H = [2 1; 1 2];

% Gradient 
g(:,1) = [2*p(1) + p(2); p(1) + 2*p(2)];
    
for k = 2:500
    ak = -(g(:,k-1)'*g(:,k-1))/(g(:,k-1)'*H*g(:,k-1));
    p(:,k) = p(:,k-1) + ak*g(:,k-1);
    g(:,k) = [2*p(1,k) + p(2,k); p(1,k) + 2*p(2,k)];
end

%PLOT
figure
hold on
contour(X1,X2,z,50)
plot(p(1,1),p(2,1),'*',p(1,:),p(2,:))
xlabel('x')
ylabel('y')
hold off
disp('first point = [1 0]')
disp('The first five points are:');
p5 = [p(:,1),p(:,2),p(:,3),p(:,4),p(:,5)]
