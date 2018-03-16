% Tom Makkink
% Exercise 2.7.1
% Solve the problem by using a two layer matrix 
%---------------------------------------------------------------------------
clc
clc 
clear all 

% Inputs and targets 
p = [0.7071 -0.7071 -0.7071 0.7071; 0.7071 0.7071 -0.7071 -0.7071];
t = [ 1 0 1 0];

yes = find(t==1);
py = p(:,yes);

% Identify those p with p1 = 0.7071 or p2 = 0.7071
t1 = any(p==0.7071);

% Identify those p with p1 = -0.7071 or p2 = 0.7071
t2 = any(p==-0.7071);

% Form the first weight matrix 
w1(1,:) = pertrain(p,t1);
w1(2,:) = pertrain(p,t2);

% Activate 
a1 = hardlim(w1*aug(p));

% second weight matrix 
w2 = pertrain(a1,t)

% Activation
a = hardlim(w2*aug(a1));

close all
figure
hold on

% Plot the decision boundaries 
plotdb(w1(1,:),p)
plotdb(w1(2,:),p)

plot(p(1,a==1),p(2,a==1),'x','markersize',15);
plot(p(1,a==0),p(2,a==0),'o');
axis([-1,1,-1,1]);
hold off


 
 



