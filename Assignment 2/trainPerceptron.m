function [P,T] = trainPerceptron()

clc
clear
close all


% Prompt the user for input pattern and target to be classified 
P = input('P = ');
T = input('T = ');

% P = [1 1 -1 -2 -1; 2 -2 -1 0 2];
% T = [1 1 0 0 0];

% Initiate W and b randomly
W = rand(1, size(P,1));
b = rand();

% Check matrices are the same size
if (length(P) ~= length(T))
    error('Matrix P and Matrix T were not of the same dimensions.')
    return
end

% Use perceptron training algorithm to search for approapriate W and b
N = W*P+b;
A = hardlim(N);
Error = T-A;
count = 0;

% Stop when the A matches t, Or the net runs more than 100 times

% Plot the points and decision boundary
% Associate symbols with 0 and 1 values
M=P(:,A==1);
O=P(:,A==0);

while (count < 10 && sum(Error.^2)>0)
    Q =P';
    dW = Error*P';
    db =sum(Error);
    W = W + dW;
    b = b + db;
    N = W*P+b;
    A = hardlim(N);
    Error = T-A;
    
    % increment loop counter
    count = count + 1;
    
    % Plot the points and decision boundary 
    % Associate symbols with 0 and 1 values
    M=P(:,A==1);
    O=P(:,A==0);

    x= -10:.01:10;
    y= (-b-W(1)*x)/W(2);
    
    plot(M(1,:),M(2,:),'.','markersize',12); hold on
    plot(O(1,:),O(2,:),'o'); hold on

    %plot the decision boundary 
    plot(x,y); 
    axis tight 
    xlabel('x')
    ylabel('y')
    %hold on;
    pause(2);
    hold off;
end

% Check for convergence, return an error message if not
if (count > 10) 
    error('Was not linearly seperable');
    return;
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