% Tom Makkink
% Exercise 3.5.5 (1)
% Backpropagation Algorithm 
%---------------------------------------------------------------------------

% We follow an input pattern, p, through a 3 - layer network 
% and use the backpropogation alogorithm to update 
% the weights. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net architecture 
% neurons:        s1       s2 = s   
% p(rx1) ------->    ------>   ------> a2(s x 1) 
%      w1(s1 X r)  w2(s2 X s1) 
% 
%      b1(s1 X 1)  b2(s2 X 1)  
%
%         f1 = tansig  f2 = purelin  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
clc 
close all 

%--------------------------------------------------------------------------
% Input patterns and targets 

p = [.5;.2;.1]; 
t = [1.5;.8];

[r,q] = size(p);
[s,q1] = size(t);

% Check that the number of samples are the same 
if (q ~= q1) 
    error ('Different sample size') 
end 

%--------------------------------------------------------------------------
% Network architecture 

% The number of neurons in each layer 
s1 = 2;
s2 = s;

% Transfer functions 
f1 = @tansig;
f2 = @purelin;

% Learning rate 
h = .01;

%--------------------------------------------------------------------------
% Initiate the weights, biases, tolerance and counter
W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);
W2 = randu(-1,1,s2,s1);
b2 = randu(-1,1,s2,1);

% tolerance 
tol = .3;

% counter
k = 1;
maxit = 100;
E(1) = 1;

%--------------------------------------------------------------------------
% Backpropagation Algorithm 

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
    D2 = eye(s2);
    D1 = diag(1 -a1.^2);

    
    % Compute sensitivities 
    %S3 = -2*D3*e;
    S2 = -2*D2*e;
    S1 = D1*W2'*S2;
    
    % Update weights and biases
    W2 = W2 - h*S2*a1';
    b2 = b2 - h*S2;
    
    W1 = W1 - h*S1*p';
    b1 = b1 - h*S1;
    
end 

%--------------------------------------------------------------------------
% Print out results

[w,z] = size(E);
count = 1;

fprintf('EE = \n');

while count < z 
    disp(E(:,count));
    count = count + 1;
end 

% Remove the first error: E(1)
E = E([2:end]) ;

% Plot the errors E(k), compute r^2 statistic and plot 
% activations vs target 
figure 
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n', tol));


%-----------------------------------------------------------------------







