% Tom Makkink 
% Ex 1.6.1 1 in Neural Networks Notes 
% logsig
x = [-5: 0.1: 5];
t= logsig(x);
%y = logsig(x);
plot(x,t)
title('logsig');
xlabel('n');
ylabel('a');