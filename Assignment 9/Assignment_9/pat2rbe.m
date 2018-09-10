% Tom Makkink
% Exercise 7.6.3 (3)
% pat2rbe
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
% Import the data 
Data = importdata('pat2rbedata.txt');
p = Data([1,2],:)
t = Data(3,:)

d = dist(p',p);
dm = max(max(d));
fprintf('max distance between inputs = %4.2f\n',dm)

% sr = input('spread range = [min, max] = ')
sr = [.3,5];


%% 
%----------------------------------------------------------------------
% Find the best spread
%----------------------------------------------------------------------
% Procedure to find the best spread:
% matrix for storing spread and r 
R = [];
for s=linspace(sr(1),sr(2),10)
    %train on training set 
    net = newrbe(p,t,s);
    % simulate on test set 
    a = sim(net,p);
    [r2,r] = correlation(a,t);
    R = [R;[s r2 r]];
end
disp('   spread      r2       r');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R')

% Find the best spread wrt r2 stat 
[mr2,i] = max(R(:,2));
bs2 = R(i,1);

% Find the best spread wrt r: correlation coeff 
[mrl,j] = max(R(:,3));
bs = R(j,1);

%% 
%----------------------------------------------------------------------
% Simulate with best spread 
%---------------------------------------------------------------------- 
net = newrbe (p,t,bs2);
atest = sim(net,p);
[r2 r] = correlation(atest,t)

% Input for simulation 
n=51;
x = linspace(-1,3,n);

% simulate on values in x 
[X,Y] = meshgrid(x,x);
XX = X(:)';
YY=Y(:)';
P = [XX;YY];
A = sim(net,P);
Asim = hardlim(A)
z = reshape(A,n,n);

%%
%----------------------------------------------------------------------
% Plot 
%----------------------------------------------------------------------
close all 
surf(x,x,z)

figure 
hold on 
contour(x,x,z)
plot(p(1,t==1),p(2,t==1),'O')
plot(p(1,t==-1),p(2,t==-1),'O')
hold off 

figure 
hold on
plot(p(1,t==1),p(2,t==1),'O')
plot(p(1,t==-1),p(2,t==-1),'O')
title('Classification problem')
hold off 

figure 
hold on
x0 = P(:,Asim==1); 
plot(x0(1,:),x0(2,:),'O')
title('Simulate on many Inputs')
hold off 


