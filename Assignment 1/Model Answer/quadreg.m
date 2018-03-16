%MHB
%Question 1.1.2(c) 
%quadratic regression
%---------------------------------------------------------------------------
clc
clear all
close all

%data
x=[0:10]';
y=[5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899]';

%Form X=[x.^2 x ones(length(x),1)]a=y
X=[x.^2 x ones(length(x),1)];

%solve for a
%Xa=y
a=X\y;

fprintf(' Form X=[x.^2 x ones(length(x),1)]a=y \n and solve for a from Xa=y:')
fprintf('\n\n coefficient list is\n\n %5.4f\n %5.4f\n %5.4f\n',a)

%or
%(X'*X)a=X'y
%Ma=b
%a=M\b


fprintf('\n Form (X''*X)a=X''y \n i.e. Ma=b \n and solve for a\n\n')

M=X'*X;
b=X'*y;
a2=M\b;

fprintf('\n\n coefficient list is\n\n %5.4f\n %5.4f\n %5.4f\n',a2)

%r2
%quadratic values at x-values
qy=polyval(a,x)

r=r2(qy,y);

fprintf('r2 = %5.4f\n',r)



%plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regression function
xx=linspace(x(1),x(end),101);
yy=polyval(a,xx);


fprintf('The regression curve and the data points:\n')

hold on
plot(x,y,'o')
plot(xx,yy)
title(sprintf('Quadratic regression function %g x^2+%g x + %g\n',a))

%report r2 in the figure
report=sprintf('r2 = %5.4f\n',r);
text(8,50,report)

xlabel('x')
ylabel('y')
hold off
