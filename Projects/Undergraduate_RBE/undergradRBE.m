% Tom Makkink
% Exercise 7.6.3 (3)
% Udergraduate problem with RBE
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
Data = importdata('ugraddata5.txt');
P = Data(:, [1 2 3]);
T = Data(:, [4 5]);

% Arrange as rows 
p = P';
t = T';

% Check 
[r,q] = size(p);
[s,qt] = size(t);

if q~=qt 
    error ('different batch sizes');
end 

%%
%----------------------------------------------------------------------
% Scale down 
%----------------------------------------------------------------------
% Scale down the inputs by row 
pMax = max(p,[],2);
pMin = min(p,[],2);
pf = 2./(pMax - pMin);            % Factors to scale down rows 
pc = -(pMax+pMin)./(pMax-pMin);   % Additive terms 
Dp = diag(pf);                    % pf down the diagonal of Dp 
pn = Dp*p+repmat(pc,1,size(p,2)); % Scale down 

% Scale down the targets 
tMax = max(t,[],2);
tMin = min(t,[],2);
tf = 2./(tMax-tMin);
tc = -(tMax + tMin)./(tMax-tMin);
Dt = diag(tf);
tn = Dt*t + repmat(tc,1,size(t,2));

%%
%---------------------------------------------------------------------
% Divide training and test sets by index 
%----------------------------------------------------------------------

% Train Index 
I1 = randperm(floor(2*q/3));      % Train 2/3rds of the data  
q1 = length(I1);

% Test index 
I2 = setdiff([1:q],I1);
q2 = length(I2);

% Training set:
p1 = p(:, I1);
t1 = t(:,I1);

ptrain = pn(:, I1);                  % Scaled versions 
ttrain = tn(:,I1);

% Test set 
p2 = p(:,I2);
t2 = t(:,I2);

ptest = pn(:, I2);                  % Scaled versions 
ttest = tn(:, I2);

d = dist(p',p);
dm = max(max(d));
fprintf('max distance between inputs = %4.2f\n',dm)

% sr = input('spread range = [min, max] = ')
sr = [.1,6];


%%
%----------------------------------------------------------------------
% Find the best spread
%----------------------------------------------------------------------
% matrix for storing spread and r 
R1 = [];
R2 = [];
for s=linspace(sr(1),sr(2),1000)
    %train on training set 
    net = newrbe(ptrain,ttrain,s);
    % simulate on test set 
    a = sim(net,ptest);
    [r2,r] = correlation(a,ttest);
    R2=[R2;[s r2(1,:) r2(2,:)]];
    R1=[R1;[s r(1,:) r(2,:)]];
end
disp('          Feature 1   Feature 2 \n');
disp('   spread      r2       r2');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R2')

disp('          Feature 1  Feature 2  \n')
disp('   spread      r       r');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R1')

%find the best spread wrt r2 stat
[mr2,i]= max(R2(:,2)+R2(:,3));
bs2 = R2(i,1);

%find the best spread wrt r: correlation coeff
[mrl,j] = max(R1(:,2) + R1(:,3));
bs = R1(j,1);
%%
%----------------------------------------------------------------------
% Simulate with the best spread
%----------------------------------------------------------------------
net = newrbe (ptrain,ttrain,bs2);
atrain = sim(net,ptrain);
atest = sim(net,ptest);

disp('Training set: ')
[r2train rtrain] = correlation(atrain,ttrain)

disp('Test set: ')
[r2test rtest] = correlation(atest,ttest)

% Scale up the data 
Atrain = diag(1./tf)*(atrain-repmat(tc,1,size(ttrain,2)));
Atest = diag(1./tf)*( atest-repmat(tc,1,size(ttest,2)) );


%%
%----------------------------------------------------------------------
% Plot 
%----------------------------------------------------------------------
% Training sets
figure 
hold on  
plot(t1(1,:),t1(1,:))
plot(t1(1,:),Atrain(1,:),'*') 
hold off
title(sprintf('Training set with spread=%f |feature 1',bs2))
xlabel('targets')
ylabel('activatins')

figure 
hold on  
plot(t1(2,:),t1(2,:))
plot(t1(2,:),Atrain(2,:),'*') 
hold off
title(sprintf('Training set with spread=%f |feature 2',bs2))
xlabel('targets')
ylabel('activatins')

% Testing Sets 
figure 
hold on  
plot(t2(1,:),t2(1,:))
plot(t2(1,:),Atest(1,:),'*') 
hold off
title(sprintf('Test set with spread=%f |feature 1',bs2))
xlabel('targets')
ylabel('activatins')

figure 
hold on  
plot(t2(2,:),t2(2,:))
plot(t2(2,:),Atest(2,:),'*') 
hold off
title(sprintf('Test set with spread=%f |feature 2',bs2))
xlabel('targets')
ylabel('activatins')






