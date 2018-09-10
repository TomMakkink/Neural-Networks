% Tom Makkink
% Exercise 5.4.2 (8)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

%----------------------------------------------------------------------
% Load trained net 
%----------------------------------------------------------------------
load school_train.mat
clear a an

% simulate on p2n t2n 
for j=1:q2 
    n1 = W1*p2n(:,j) + b1;
    a1 = f1(n1);
    n2 = W2*a1 + b2;
    a2 = f2(n2);
    an(:,j) = a2;
end 

% Scale up 
a = diag(1./tf)*(an-repmat(tc,1,size(t2,2)));

M = [t2;a];
disp('  Targets      Activations');
fprintf('%4.2f \t%4.2f \t%4.2f \t%4.2f\n', M);

t21 = t2(1,:);
a21 = a(1,:);

% Assessing the degree of fit 
r2 = rsq(t2,a);

[R1,PV1] = corrcoef(a(1,:),t2(1,:));
fprintf('Training: Test Scores:\n\n');
fprintf(' Corr coeff: %g\n p value: %g\n r2: %g\n\n', R1(1,2),PV1(1,2),r2(1));
disp('------------------------------------------------------------------');

figure 
plot(t21, t21, t21, a21, '*');
title(sprintf('Testing: Test marks with %g observations\n',q));
