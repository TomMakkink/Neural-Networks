% Tom Makkink
% Exercise 8.2.6
% Dynamic Neural Networks 
%---------------------------------------------------------------------------
clc;
clear;

x(1)=1;
x(2)=1;
n=100;
for i=3:n
   x(i)=.25*x(i-2)+.76*x(i-1);
end

y(1)=1;
y(2)=1;
n=100;
for i=3:n
    y(i)=3*(x(i))^2-x(i);
end

v = [x;y];

save ts1seq_mod.mat