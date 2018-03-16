% Neural Networks Exercise 2b 
% Thomas Makkink
clear
clc
clf
format compact
% the data 
x= 0:10;
y =[0 1.8127 3.2968 4.5119 5.5067 6.3212 6.9881 7.5340 7.9810 8.3470 8.6466];
% the proposed functionality (fh is a handle to the function)
% f(x) = M(1 ? e^?kx)
fh=@(M, k, x) M*(1.-exp(-k*x));

% guess values for parameters (beta0)
b0=[0.5,0.5];
% plot the raw data
hold on
plot(x,y,'s','markersize',5,'color',[0,0,0]);  
hold off
     
% determine best fit values for coefficient (bhat)
%    bhat=nlinfit(x,y,fh,b0);
% plot the fit
%    xf = linspace(x(1), x(length(x)));
%    plot(xf,fh(bhat,xf),'linewidth',1,'color',[1,0,0]);      
%    legend('original data','fit data','location','Best') % the result 
%     bhat(1)
%    bhat(2)

