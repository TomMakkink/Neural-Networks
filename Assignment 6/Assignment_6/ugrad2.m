% Tom Makkink
% Exercise 5.4.2 (1)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
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
%         W1(s1Xr)       
% p(2Xq) ----------> a1 
%         b1(s1X1)       
%
%                logsig        
%----------------------------------------------------------------------

% Layer sizes 
s1 = s;

% Initialise 
W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);

% Transfer Functions 
f1 = @logsig;

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
        an(:,j)=a1;

        % jth error vector 
        e(:,j) = t1n(:,j) - an(:,j);

        % Derivative matrices 
        D1=diag((1-a1).*a1);

        % Sensitivities 
        S1 = -2*D1*e(:,j);

        % Update the weights and the biases 
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
fprintf('Training: Semester 1:\n\n');
fprintf(' Corr coeff: %g\n p value: %g\n r2: %g\n\n', R1(1,2),PV1(1,2),r2(1));
disp('------------------------------------------------------------------');

[R2,PV2] = corrcoef(a(2,:),t1(2,:));
fprintf('Training: Semester 2:\n\n');
fprintf(' Corr coeff: %g\n p value: %g\n r2: %g\n\n', R2(1,2),PV2(1,2),r2(2));
disp('------------------------------------------------------------------');


%----------------------------------------------------------------------
% Plot 
%----------------------------------------------------------------------
t11 = t1(1,:);
a11 = a(1,:);

t12 = t1(2,:);
a12 = a(2,:);

% Plot the error (performance function)
close all 
E = E(2:end);
plot(E);
title('MSE');

figure 
hold on 
plot(t11,t11);
plot(t11,a11,'*');
title(sprintf('Training: Semester 1 with %g samples\n',q));
hold off 

figure 
hold on 
plot(t12,t12);
plot(t12,a12,'*');
title(sprintf('Training: Semester 2 with %g samples\n',q));
hold off 

%----------------------------------------------------------------------
% Compare with a linear model 
%----------------------------------------------------------------------
disp('Compare with a linear model');

% Find w,b such that ||wp+b-t|| is a minimum 
W = t/aug(p);

% Activate using W
y = W*aug(p);

% Linear model on training set 
L1 = y(:,I1);

figure 
hold on 
plot(t11,t11); 
plot(t11,L1(1,:),'*');
title('Linear model: First semester');
hold off

figure 
hold on 
plot(t12, t12);
plot(t12,L1(2,:),'*');
title('Linear model: Second semester');
hold off


% r2 for linear model on training set 
r2L = rsq(t1,L1);

fprintf('Training: Linear fit Semester 1 %5.4f\n', r2L(1));
fprintf('Training: Linear fit Semester 2 %5.4f\n', r2L(2));

% Save the variables from training 
%save ugrad_train.mat












