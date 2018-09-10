% Tom Makkink
% Exercise 6.1.3 (2)
% HousingV2_train
%---------------------------------------------------------------------------

clc 
clear all
close all 

%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
load housingV2_train.mat
clear a an

% simulate on p2n t2n 
for j=1:q2 
    n1 = W1*p2n(:,j) + b1;
    a1 = f1(n1);
    n2 = W2*a1 + b2;
    a2 = f2(n2);
    n3 = W3*a2 + b3;
    a3 = f3(n3);
    an(:,j) = a3;
end 

% Scale up 
a = diag(1./tf)*(an-repmat(tc,1,size(t2,2)));

M = [t2;a];
disp('  Targets      Activations');
fprintf('%4.2f \t%4.2f \t%4.2f \t%4.2f\n', M);

% Assessing the degree of fit 
r2 = rsq(t2,a);

[R1,PV1] = corrcoef(a,t2);
fprintf('Training: Semester 1:\n\n');
fprintf(' Corr coeff: %g\n p value: %g\n r2: %g\n\n', R1(1,2),PV1(1,2),r2(1));
disp('------------------------------------------------------------------');


figure 
plot(t2, t2, t2, a, '*');
title(sprintf('Testing: semester 1 with %g observations\n',q));







