% Tom Makkink
% Exercise 4.8.3 (1)
% Performance surfaces  
%---------------------------------------------------------------------------

clear all
close all
clc

x=[-1:.01:1];
y=x;
[X, Y]=meshgrid(x,y);

% Function 
z = (X - Y).^4 + 8*X.*Y - X + Y + 3;

% Initial point
p1 = input('first point = ');
p(:,1) = p1';

% Gradient 
g(:,1) = [-4*(p(2)-p(1)).^3 + 8*p(2) - 1; 4*(p(2)-p(1)).^3 + 8*p(1) + 1];
for k = 2:500
    
    H = [12*(p(2,k-1)-p(1,k-1)).^2, -12*(p(2,k-1)-p(1,k-1)).^2+8;
         -12*(p(2,k-1)-p(1,k-1)).^2+8, 12*(p(2,k-1)-p(1,k-1)).^2];
    p(:,k) = p(:,k-1)-(inv(H))*g(:,k-1);
    g(:,k) = [-4*(p(2,k)-p(1,k)).^3+8*p(2,k)-1;4*(p(2,k)-p(1,k)).^3+8*p(1,k)+1];
    
end 

%PLOT
figure
hold on
contour(X,Y,z,30)
plot(p(1,1),p(2,1),'*',p(1,:),p(2,:))
xlabel('x')
ylabel('y')
hold off
disp('first point = [1 0]')
disp('The first five points are:');
p5=[p(:,1),p(:,2),p(:,3),p(:,4),p(:,5)]
disp('Converging to');
disp('c = ');
disp(p(:,5));







