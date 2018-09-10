% Tom Makkink
% Exercise 5.5.1 (2)
% Ugrad problem with momentum 
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
%----------------------------------------------------------------------
% Divide training and test sets by index 
%----------------------------------------------------------------------

%test index
m=size(p,2);
ti=[1:3:m];
%training index
tri=setdiff([1:m],ti);
%training and test sets:
ptrain=p(:,tri);
ttrain=t(:,tri);
ptest=p(:,ti);
ttest=t(:,ti);

%%
%----------------------------------------------------------------------
% Network architecture 
%----------------------------------------------------------------------
%
%         W1(s1Xr)       W2(s2Xs1)      W3(s3Xs2)
% p(2Xq) ----------> a1 ----------> a2 ----------> a3 (s3Xq)
%         b1(s1X1)       b2(s2Xs1)      b3(s3Xs2) 
%
%                  tansig         logsig          purelin
%----------------------------------------------------------------------

% Layer sizes 
s1 = 5;
s2 = 5;
s3 = s;

% Transfer Functions 
f1 = @tansig;
f2 = @logsig;
f3 = @purelin;

% epoch counter 
k = 1;

% Initialise by forming six books with the first weight matrices and biases
% on the first pages
W1(:,:,k)=randu(-1,1,s1,r);
b1(:,:,k)=randu(-1,1,s1,1);

W2(:,:,k)=randu(-1,1,s2,s1);
b2(:,:,k)=randu(-1,1,s2,1);

W3(:,:,k)=randu(-1,1,s3,s2);
b3(:,:,k)=randu(-1,1,s3,1);

%%
%----------------------------------------------------------------------
% Training Parameters 
%----------------------------------------------------------------------
% Learning rate 
r = .005;

% Momentum 
q = 0.05;


%% 
%----------------------------------------------------------------------
% Propogate once through the network and get first error
%----------------------------------------------------------------------
m1 = size(ptrain,2);

%obtain error on first epoch
for j=1:m1
    n1=W1(:,:,k)*pn(:,j)+b1(:,:,k);
    a1=f1(n1);
    
    n2=W2(:,:,k)*a1+b2(:,:,k);
    a2=f2(n2);
    
    n3=W3(:,:,k)*a2+b3(:,:,k);
    a3=f3(n3);
    
    %j th error vector
    E(j)=sum((tn(:,j)-a3).^2);
end
%error from first epoch
E=sum(E.^2);
EE=[E];
 
%%
%----------------------------------------------------------------------
% Backpropogate
%----------------------------------------------------------------------
d3=size(a3,1);
d2=size(a2,1);
d1=size(a1,1);

f3dot=eye(d3);
f2dot=diag((1-a2).*a2);
f1dot=diag(1-a1.^2);

s3=-2*f3dot*(tn(:,j)-a3);
s2=f2dot*W3(:,:,k)'*s3;
s1=f1dot*W2(:,:,k)'*s2;

%first update
W3(:,:,k+1)=W3(:,:,k)-r*s3*a2';
b3(:,:,k+1)=b3(:,:,k)-r*s3;

W2(:,:,k+1)=W2(:,:,k)-r*s2*a1';
b2(:,:,k+1)=b2(:,:,k)-r*s2;

W1(:,:,k+1)=W1(:,:,k)-r*s1*pn(:,j)';
b1(:,:,k+1)=b1(:,:,k)-r*s1;

% Set tolerance 
tol=1e-6;

% Max iterations 
maxit = 200;

k = 2;

%%
%----------------------------------------------------------------------
% Train on normalised data 
%----------------------------------------------------------------------
while E > tol & k < maxit 
    for j = 1:m1
        n1=W1(:,:,k)*pn(:,j)+b1(:,:,k);
        a1=f1(n1);
        n2=W2(:,:,k)*a1+b2(:,:,k);
        a2=f2(n2);
        n3=W3(:,:,k)*a2+b3(:,:,k);
        a3=f3(n3);
        
        %error for j th pattern
        E(j)=sum((tn(:,j)-a3).^2);
        
        d3=size(a3,1);
        d2=size(a2,1);
        d1=size(a1,1);
        
        f3dot=eye(d3);
        f2dot=diag((1-a2).*a2);
        f1dot=diag(1-a1.^2);
        
        s3=-2*f3dot*(tn(:,j)-a3);
        s2=f2dot*W3(:,:,k)'*s3;
        s1=f1dot*W2(:,:,k)'*s2;

        %update
        W3(:,:,k+1)=W3(:,:,k)-r*s3*a2'+q*(W3(:,:,k)-W3(:,:,k-1));
        b3(:,:,k+1)=b3(:,:,k)-r*s3+q*(b3(:,:,k)-b3(:,:,k-1));

        W2(:,:,k+1)=W2(:,:,k)-r*s2*a1'+q*(W2(:,:,k)-W2(:,:,k-1));
        b2(:,:,k+1)=b2(:,:,k)-r*s2+q*(b2(:,:,k)-b2(:,:,k-1));

        W1(:,:,k+1)=W1(:,:,k)-r*s1*pn(:,j)'+q*(W1(:,:,k)-W1(:,:,k-1));
        b1(:,:,k+1)=b1(:,:,k)-r*s1+q*(b1(:,:,k)-b1(:,:,k-1));
    end 

% Error for epoch
E = sum(E.^2);

% Accumulate MSE into vector: EE
EE = [EE;E];

% Update 
k = k + 1;
end

%%
%----------------------------------------------------------------------
% Plot 
%----------------------------------------------------------------------

% Plot the error (performance function)
close all
plot(EE)
xlabel('epochs')
ylabel('error')
title(sprintf('Performance with \n LR=%5.4f and Momentum=%5.4f\n epochs = %d',r,q,k))

%display errors
format long
epochs=[1:k-1];
errors=EE(:)';
%printout= [epochs; errors];
%fprintf('epoch: %d error: %16.15f\n',printout)

%disp(EE(:));
W3=W3(:,:,end);
W2=W2(:,:,end);
W1=W1(:,:,end);

b3=b3(:,:,end);
b2=b2(:,:,end);
b1=b1(:,:,end);

% Save variables 
save ugrad_mom.mat

disp('Training complete');







