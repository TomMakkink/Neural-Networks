% Tom Makkink
% Exercise 8.2.6
% Dynamic Neural Networks 
%---------------------------------------------------------------------------
% Generate a sequence
clc;
clear; 

x(1) = 1;
x(2) = 1;
x(3) = 3; 

for k = 4: 100
     x(k) = 2*x(k-1)+x(k-2)-3*x(k-3)
end

save ts2aseq.mat




