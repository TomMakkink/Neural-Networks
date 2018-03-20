% graddemo 
%
close all 

% surface 
theta = [0:pi/50:2*pi];
rad = [0:.01:2];
[T,R] = meshgrid(theta,rad);
[X,Y] = pol2cart(T,R);
Z = 3 * X.^2 + X.*Y + 5*Y.^2;
figure 
surfl(X,Y,Z)

% Contour 
x = [-2:.1:2];
y=x;
[x y] = meshgrid(x, y);
z = (3*x.^2 + x.*y + 5*y.^2);

figure 
[zx zy] = gradient(z);
hold on 
contour(x, y, z, 20);
xlabel('x');
ylabel('y');

quiver(x,y,zx,zy);
hold off 
xlim([-1 1]);
ylim([-1 1]);

