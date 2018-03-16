function plotdb(w,p) 
% Plots the decision boundary for w_{1x3} and patterns p
% Isolate bias and weight from W
% Plot the decision boundary 

b = w(:,3);
w = [w(:,1) w(:,2)];

x= -10:.01:10;
y= (-b-w(1)*x)/w(2);
plot(x,y); 
%axis tight 
xlabel('x')
ylabel('y')

