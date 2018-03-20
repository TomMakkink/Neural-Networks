% Tom Makkink
% Exercise 3.5.5 (1)
% Backpropagation Algorithm 
%---------------------------------------------------------------------------

% We follow an input pattern, p, through a 2 - layer network 
% and use the backpropogation alogorithm to update 
% the weights. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net architecture 
% neurons:        s1        s2 = s
% p(rx1) ------->    ------>     ------> a2(s x 1) 
%      w1(s1 X r)  w2(s2 X s1)  
% 
%      b1(s1 X 1)  b2(s2 X 1) 
%
%             f1 = logsig  f2 = tansig  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
clc 
close all 

%-------------------------------------------------------------------------
% Data and data validation 

%input pattern 
p = [.5;.2;.1];

% Target 
t = [1.5;.8];

[r,q] = size(p);
[s,q1] = size(t);

% Check that the number of samples are the same 
if (q ~= q1) 
    error ('Different sample size') 
end 

% The number of neurons in each layer 
s1 = 2;
s2 = s;

% Transfer functions 
f1 = @tansig;
f2 = @logsig;

% Learning rate 
h = .05;

% Initiate the weights and biases 
W1 = randu(0,1,s1,r);
b1 = randu(0,1,s1,1);
W2 = randu(0,1,s2,s1);
b2 = randu(0,1,s2,1);

% tolerance 
tol = .3;

% counter
k = 1;
maxit = 120;
E(1) = 1;

while abs(E)>tol & k < maxit
    k = k + 1;
    
    % Propagate through the network 
    n1 = W1*p + b1;
    a1 = f1(n1);
    n2 = W2*a1 + b2;
    a2 = f2(n2);
    
    % Compute error 
    e = t - a2;
    sse = sum(e.^2);
    E(k) = sse;
    
    % Derivative matrices
    % eye - identity matrix
    D1 = diag(1 -a1.^2);
    D2 = diag((1-a2).*a2);
    
    % Compute sensitivities 
    S2 = -2*D2*e;
    S1 = D1*W2'*S2;
    
    % Update weights and biases
    W2 = W2 - h*S2*a1';
    b2 = b2 - h*S2;
    
    W1 = W1 - h*S1*p';
    b1 = b1 - h*S1;
end 

% Remove the first error: E(1)
E = E([2:end]) ;

% Plot the errors E(k)
figure 
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n', tol));

%-----------------------------------------------------------------------
% Simulate on new sample size

fprintf('simulate on new p = [.46;.22;.11]\n');
p = [.46;.22;.11];

% Produce activation 
n1 = W1*p + b1;
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);

% Print out results 
fprintf('p = \n');
disp(p);
fprintf('The new activation is \n');
disp(a2);

%-----------------------------------------------------------------------
% Simulate on new sample size

fprintf('simulate on new p = [.3;.4;.2]\n');
p = [.3;.4;.2];

% Produce activation 
n1 = W1*p + b1;
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);

% Print out results 
fprintf('p = \n');
disp(p);
fprintf('The new activation is \n');
disp(a2);

%-----------------------------------------------------------------------
% Simulate on new sample size

fprintf('simulate on new p = [1.2;1.5;1.3]\n');
p = [1.2;1.5;1.3];

% Produce activation 
n1 = W1*p + b1;
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);

% Print out results 
fprintf('p = \n');
disp(p);
fprintf('The new activation is \n');
disp(a2);

%-----------------------------------------------------------------------
% Simulate on new sample size

fprintf('simulate on new p = [2.1;2.6;2.4]\n');
p = [2.1;2.6;2.4];

% Produce activation 
n1 = W1*p + b1;
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);

% Print out results 
fprintf('p = \n');
disp(p);
fprintf('The new activation is \n');
disp(a2);

fprintf('Q3) As the inputs vary further from p, the activation differs from the targets.\n')
fprintf('As shown above');







