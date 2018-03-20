% Tom Makkink
% Exercise 3.5.5 (2)
% Backpropagation Algorithm 
%---------------------------------------------------------------------------

% We follow an input pattern, p, through a 3 - layer network 
% and use the backpropogation alogorithm to update 
% the weights. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net architecture 
% neurons:        s1        s2 = s
% p(rx1) ------->    ------>   ------> a2(s x 1) 
%      w1(s1 X r)  w2(s2 X s1) 
% 
%      b1(s1 X 1)  b2(s2 X 1)  
%  
%       f1 = logsig  f2 = tansig 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
clc 
close all 

%--------------------------------------------------------------------------
% Run backprop1.m to retrieve W1, W2, b1 and b2
load('backprop1data.mat');

fprintf('Please enter a new input pattern matrix 3x1: ');
p = (input('p = '));
t = [1.5;.8];

[r,q] = size(p);
[s,q1] = size(t);

% Check that the number of samples are the same 
if (q ~= q1) 
    error ('Different sample size') 
end 

%--------------------------------------------------------------------------
% Transfer functions 
f1 = @logsig;
f2 = @tansig;

% Propagate through the network 
n1 = W1*p + b1;
a1 = f1(n1);
n2 = W2 * a1 + b2;
a2 = f2(n2);

% Print out results
fprintf('Input: \n');
disp(p);
fprintf('Activations: \n');
disp(a2);





