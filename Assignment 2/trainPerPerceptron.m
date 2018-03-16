function [W,b,count] = trainPerPerceptron(P, T, maxI)

clc
clear
close all


% % Prompt the user for input pattern and target to be classified 
% P = input('P = ');
% T = input('T = ');
% P = [ 1 1 2 3; 1 1 1 2; 1 2 2 4];
% T = [1 1 0 1; 1 1 1 0];

% Check matrices are the same size
if (length(P) ~= length(T))
    error('Matrix P and Matrix T were not of the same dimensions.')
end

% Initiate W randomly
W = [rand(1, size(P,1)); rand(1, size(P,1))];
b = [rand(); rand()];

% Augment W so the bias is the last row of W
Pa = [P; ones(1,size(P,2))];
Wa = [W b];

% B = repmat(b, 1, size(P,2));
% N = W * P + B;

% Activation
A = hardlim(Wa*Pa);

% Error
Error = T-A;

% Loop counter
count = 1;

% Stop when the A matches t, Or the net runs more than 100 times
while (count <= maxI && any(any(Error) ~= 0))
    % Use perceptron training algorithm to search for approapriate W and b
    dWa = Error*Pa';
    Wa = Wa + dWa;
    Error = T - hardlim(Wa*Pa);
    
    % increment loop counter
    count = count + 1;
    
end

% Check for convergence, return an error message if not
if (any(Error)) 
    error('Did not converge.');
end 

fprintf('P is the matrix of patterns and is rxm, P = P \n');
disp(P);
fprintf('T is the matrix of targets and is 1xm, T = T \n');
disp(T);
fprintf('Iterations = \n')
disp(count);
fprintf('Weights = \n')
disp(W);
fprintf('Bias = \n')
disp(b)
    
end 