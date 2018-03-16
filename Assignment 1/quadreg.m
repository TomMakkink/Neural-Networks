% Tom Makkink 
% Ex 1.1.4 1(c) in Neural Networks Notes 
clear
clc
clf

% The Data
x=0:10;
y =[5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899];

% Creating the Matrices
M11=sum(x.^4);
M12=sum(x.^3);
M13=sum(x.^2);
M21=sum(x.^3);
M22=sum(x.^2);
M23=sum(x);
M31=sum(x.^2);
M32=sum(x);
M33=sum(length(x));
b1=sum((x.^2).*y);
b2=sum(x.*y);
b3=sum(y);
b=[b1;b2;b3];
M=[M11 M12 M13;M21 M22 M23; M31 M32 M33];

%Expression to find Co-efficients
a=M\b
a2=a(1);
a1=a(2); 
a0=a(3);

f=a2*x.^2+a1*x+a0;

hold on
plot(x,f, 'o')
hold off