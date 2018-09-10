% Tom Makkink
% Exercise 5.4.2 (8)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
Data = importdata('school.txt');
P = Data(:, [1 2]);
T = Data(:, 3);

% Arrange as rows 
p = P';
t = T';

% Check 
[r,q] = size(p);
[s,qt] = size(t);

if q~=qt 
    error ('different batch sizes');
end 

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

%----------------------------------------------------------------------
% Network architecture 
%----------------------------------------------------------------------
%
%         W1(s1Xr)       W2(s2Xs1)    
% p(2Xq) ----------> a1 ----------> a2 (s3Xq)
%         b1(s1X1)       b2(s2Xs1)       
%
%                  purelin        purelin
%----------------------------------------------------------------------

% Layer sizes 
s1 = 3;
s2 = s;

% Initialise 
W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);
W2 = randu(-1,1,s2,s1);
b2 = randu(-1,1,s2,1);

% Transfer Functions 
f1 = @purelin;
f2 = @purelin;

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
maxit = 10;

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
        an(:,j) = a2;

        % jth error vector 
        e(:,j) = t1n(:,j) - an(:,j);

        % Derivative matrices 
        D2 = eye(s2);
        D1 = eye(s1);

        % Sensitivities 
        S2 = -2*D2*e(:,j);
        S1 = D1*W2'*S2;

        % Store sensitivities 
        SS([1:s1],k-1,1) = S1;
        SS([s1+1:s1+s2],k-1) = S2;

        % Update the weights and the biases 
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


%----------------------------------------------------------------------
% Assessing the degree of fit 
%----------------------------------------------------------------------
% R^2 statistic 
r2 = rsq(t1,a);

% Corrcoeff 
[R1,PV1] = corrcoef(a(1,:),t1(1,:));
fprintf('Training: Test Results:\n\n');
fprintf(' Corr coeff: %g\n p value: %g\n r2: %g\n\n', R1(1,2),PV1(1,2),r2(1));
disp('------------------------------------------------------------------');

%----------------------------------------------------------------------
% Plot 
%----------------------------------------------------------------------
t11 = t1(1,:);
a11 = a(1,:);

figure
plot(t11,t11,t11,a11,'*')
title(sprintf('First year mark with %g observations\n',q))

% Plot the error (performance function)
figure
E = E(2:end);
plot(E);
title('MSE');
xlabel('Iterations');
ylabel('Error');

% Save variables 
save school_train.mat

disp('Training complete');
