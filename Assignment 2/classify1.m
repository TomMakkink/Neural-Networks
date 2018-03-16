% Tom Makkink
% Question 2.1.1(1) 
% Classifying input
%---------------------------------------------------------------------------
clc
clear
close all

% Input pattern to be classified 
P = [.6 .9 .3 .9 .4 1; .1 .2 .2 .9 .8 .9];
% Guess a weight, and related bias
W = [-1 -1];
b = 1.5;
A = hardlim(W*P + b);

% Associate symbols with 0 and 1 values
M=P(:,A==1);
O=P(:,A==0);

x= -1:.01:2;
y= - x + 1.5;

close all

%Plot 1's as dots and 0's as circles
hold on 
plot(M(1,:),M(2,:),'.','markersize',12)
plot(O(1,:),O(2,:),'o')

%plot the decision boundary 
plot(x,y)
axis tight 

xlabel('x')
ylabel('y')
hold off