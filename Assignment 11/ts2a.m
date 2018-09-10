% Tom Makkink
% Exercise 8.2.6
% Dynamic Neural Networks 
%---------------------------------------------------------------------------
% Load the data 
load ts2aseq.mat

% Using Window Sliding Alogrithm Approach 
% First order linear reccurence 
[p,t]=delay(x,1)

A=t/p
a=A*p;
[a;t]
r2(1)=r2(a,t)

% Second order linear recurrence 
[p,t]=delay(x,2)
A=t/p
a=A*p;
[a;t]
r2(2)=r2(a,t)

% Third order linear recurrence 
[p,t]=delay(x,3)
A=t/p
a=A*p;
[a;t]
r2(3)=r2(a,t)