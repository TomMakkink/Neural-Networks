% Tom Makkink
% Exercise 3.5.5 (1)
% Backpropagation Algorithm 
%---------------------------------------------------------------------------

% We follow an input pattern, p, through a 3 - layer network 
% and use the backpropogation alogorithm to update 
% the weights. 
% We make toy data from a known function 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net architecture 
% neurons:        s1        s2         s3=s
% p(rx1) ------->    ------>   ------->    ------> a3(s x 1) 
%      w1(s1 X r)  w2(s2 X s1) w3(s3 X s2) 
% 
%      b1(s1 X 1)  b2(s2 X 1)  b3(s3 X 1)
%
%             f1 = tansig  f2 = tansig  f3 = purelin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
clc 
close all 

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
s1 = 5;
s2 = 3;
s3 = s;

% Transfer functions 
f1 = @tansig;
f2 = @tansig;
f3 = @purelin;

% Learning rate 
h = .01;

% Initiate the weights and biases 
W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);
W2 = randu(-1,1,s2,s1);
b2 = randu(-1,1,s2,1);
W3 = randu(-1,1,s3,s2);
b3 = randu(-1,1,s3,1);

% tolerance 
tol = .3;

% counter
k = 1;
maxit = 100;
E(1) = 1;

while abs(E)>tol & k < maxit
    k = k + 1;
    
    % Propagate through the network 
    n1 = W1*p + b1;
    a1 = f1(n1);
    n2 = W2*a1 + b2;
    a2 = f2(n2);
    n3 = W3*a2 + b3;
    a3 = f3(n3);
    
    % Compute error 
    e = t - a3;
    sse = sum(e.^2);
    E(k) = sse;
    
    % Derivative matrices
    % eye - identity matrix
    D3 = eye(s3);
    D2 = diag(1 -a2.^2);
    D1 = diag(1 -a1.^2);
    
    % Compute sensitivities 
    S3 = -2*D3*e;
    S2 = D2*W3'*S3;
    S1 = D1*W2'*S2;
    
    % Update weights and biases
    W3 = W3 - h*S3*a2';
    b3 = b3 - h*S3;
    
    W2 = W2 - h*S2*a1';
    b2 = b2 - h*S2;
    
    W1 = W1 - h*S1*p';
    b1 = b1 - h*S1;
    
end 


[w,z] = size(E);
count = 1;
fprintf('EE = \n');
while count < z 
    disp(E(:,count));
    count = count + 1;
end 

% Remove the first error: E(1)
E = E([2:end]) ;

%-----------------------------------------------------------------------

fprintf('simulate on new p = [.46;.22;.11]\n');
p = [.46;.22;.11];

% Produce activation 
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);
n3 = W3 * a2 + b3;
v = f3(n3);
w = 2*sin(3*v)+1;

% Print out results 
fprintf('p = \n');
disp(p);
fprintf('The new activation is \n');
disp(a2);

% Plot the errors E(k)
figure 
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n', tol));





