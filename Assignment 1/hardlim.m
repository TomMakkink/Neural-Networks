% Tom Makkink 
% Ex 1.6.1 1 in Neural Networks Notes 
% hardlim 
function h=hardlim(n)

x = -5: 0.1: 5;
y = hardlim(x);
plot(x,y)
title('hardlim')
xlabel('n')
ylabel('a')
