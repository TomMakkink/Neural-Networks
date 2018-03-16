% pattern1 
% Accepts a matrix of P of patterns and identifies 
% the column as feature vectors of a mango or a orange 
%
% 0                           1 
%   ---> Mango                   ---> Orange
% 0                           1
%
P = input('P = ');
W = [-1 -1]; 
b = 1;
A = hardlim(W*P + b)

% identify the mangoes:
M=P(:,A==1);

% identify the oranges:
O=P(:,A==0);

x= -1:.01:2;
y=-x+1;

close all

%Plot mangoes as dots and oranges as circles
hold on 
plot(M(1,:),M(2,:),'.','markersize',12)
plot(O(1,:),O(2,:),'o')

%plot the decision boundary 
plot(x,y)
axis tight 
hold off