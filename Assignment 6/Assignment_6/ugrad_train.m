% ugrad_train 

clc 
clear 
close all 

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

% Train Index 
I1 = randperm(floor(2*q/3));      % Train 2/3rds of the data  
q1 = length(I1);

% Test index 
I2 = setdiff([1:q],I1);
q2 = length(I2);

% Training set:
p1 = p(:, I1);
t1 = t(:,I1);

p1n = pn(:, I1);                  % Scaled versions 
t1n = tn(:,I1);

% Test set 
p2 = p(:,I2);
t2 = t(:,I2);

p2n = pn(:, I2);                  % Scaled versions 
t2n = tn(:, I2);

%%
%----------------------------------------------------------------------
% Network architecture 
%----------------------------------------------------------------------
%
%         W1(s1Xr)       W2(s2Xs1)       W3(s3Xs2)
% p(2Xq) ----------> a1 ----------> a2  ----------> a3 (s3Xq)
%         b1(s1X1)       b2(s2Xs1)       b3(s3Xs2)
%
%                 tansig          logsig          purelin
%----------------------------------------------------------------------

% Layer sizes 
s1 = 9;
s2 = 9;
s3 = s;

% Initialise 
W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);
W2 = randu(-1,1,s2,s1);
b2 = randu(-1,1,s2,1);
W3 = randu(-1,1,s3,s2);
b3 = randu(-1,1,s3,1);

% Transfer Functions 
f1 = @tansig;
f2 = @logsig;
f3 = @purelin;

%----------------------------------------------------------------------
% Training Parameters 
%----------------------------------------------------------------------
% Learning rate 
h = .05;

% epoch counter 
k = 1;

% Initiate error for epoch 
mse = 1;

% Collect erros in EE
E(1) = mse;

% Set tolerance 
tol=1e-8;

% Max iterations 
maxit = 800;

%----------------------------------------------------------------------
% Train on normalised data 
%----------------------------------------------------------------------
while mse > tol & k < maxit 
    k = k+1;
    for j = 1:q1
        % Propagate input patterns through the network 
        n1 = W1*p1n(:,j) + b1;
        a1 = f1(n1);
        n2 = W2*a1 + b2;
        a2 = f2(n2);
        n3 = W3*a2 + b3;
        a3 = f3(n3);
        an(:,j) = a3;

        % jth error vector 
        e(:,j) = t1n(:,j) - an(:,j);

        % Derivative matrices 
        D3 = eye(s3);
        D2 = diag((1-a2).*a2);
        D1 = diag(1 -a1.^2);

        % Sensitivities 
        S3 = -2*D3*e(:,j);
        S2 = D2*W3'*S3;
        S1 = D1*W2'*S2;

        % Store sensitivities 
%         SS([1:s1],k-1,1) = S1;
%         SS([s1+1:s1+s2],k-1) = S2;
%         SS([s1+s2+1: s1 + s2 + s3],k-1) = S3;

        % Update the weights and the biases 
        W3 = W3 - h*S3*a2';
        b3 = b3-h*S3;

        W2 = W2 - h*S2*a1';
        b2 = b2 - h*S2;

        W1 = W1 - h*S1*p1n(:,j)';
        b1 = b1 - h*S1;
    end 
    
    % Error for epoch 
    mse = sum(sum(e).^2)/q1;

    % accumulate MSE into vector: EE
    E(k) = mse; 
end

% scale up 
a = diag(1./tf)*(an-repmat(tc,1,size(t1,2)));

% Save the variables from training 
save ugrad_train.mat

disp('Training complete.');














