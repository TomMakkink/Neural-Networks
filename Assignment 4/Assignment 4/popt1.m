% popt1
% Performance optimisation
% steepest descent algorithm 
% 

clear g p 
close all 
x = [-1:.01:1];
y = x;
[X Y] = meshgrid(x,y);
z = X.^2 + 25*Y.^2

disp('learning rates of about .001 produce convergence')
disp('but at about .05 the algorithm becomes unstable')
disp('We discover that')
disp('we must have lr<2/(max eigenvalue) = 2/25 here')

% Learning rate 
a = 0.001;

% Initial point 
p(:,1) = input('First point = ');

% Gradient 
g(:,1) = [2*p(1); 50*p(2)];
for k = 2:500
    p(:,k) = p(:,k-1)-a*g(:,k-1);
    g(:,k) = [2*p(1,k); 50*p(2,k)];
end 

figure 
hold on 
contour(X, Y, z)
plot(p(1,:),p(2,:));
hold off 







