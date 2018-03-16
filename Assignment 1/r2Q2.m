% Tom Makkink 
% Ex 1.1.4 5 in Neural Networks Notes 

function r=r2Q2(x,y)
%function r=r2(a,t)
%Finds the R^2 statistic for 
%a: activation vector
%t: target vector
clear
clc
clf

% The Data (1)
x=[0:10];
y =[0 1.8127 3.2968 4.5119 5.5067 6.3212 6.9881 7.5340 7.9810 8.3470 8.6466];


% Use polyfit to computer a linear progression 
p = polyfit(x, y, 1);
yfit = polyval(p,x);
yresid = y - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(y)-1) * var(y);
rsq1 = 1 - SSresid/SStotal;
disp(rsq1);
end

