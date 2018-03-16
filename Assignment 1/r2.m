% Tom Makkink 
% Ex 1.1.4 5 in Neural Networks Notes 

function r=r2(x,y)
%function r=r2(a,t)
%Finds the R^2 statistic for 
%a: activation vector
%t: target vector
clear
clc
clf

% The Data (1)
x=0:10;
y =[5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899];

% Use polyfit to computer a linear progression 
p = polyfit(x, y, 1);
yfit = polyval(p,x);
yresid = y - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(y)-1) * var(y);
rsq1 = 1 - SSresid/SStotal;
disp(rsq1);
end

