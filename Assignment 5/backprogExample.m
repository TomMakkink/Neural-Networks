%input pattern 
p = [.5;.2;.1]

% Target 
t = [1.5;.8]

% Initiate weights and biases randomly 
% randu (starting, ending, Mrows, Mcolumns)
W1 = randu(0, 1, 2, 3);
b1 = randu(0,1,2,1);
W2 = randu(0, 1, 2, 2);
b2 = randu(0,1,2,1);

% Compute activations through the network  
n1 = W1 * p + b1;
a1 = tansig(n1);
n2 = W2 * a1 + b2
a2 = logsig(n2)

% Compute the error 
E = sum((t-a2).^2);

% Compute the derivative matrices 
D2 = [(1-a2(1))*a2(1) 0; 0 (1-a2(2))*a2(2)];
D1 = [1-a1(1)^2 0; 0 1-a1(2)^2];

% Compute the sensitivities 
% Note: the component is larger than the second 
% because the greatest error was in the second component 
% sensitivity in last layer 
S2 = -2 * D2 * (t-a2);
% Sensitivity in other layers 
S1 = D1 * W2' * S2;

% Learning rate 
h = .1;

% Update the weights and biases 
W2 = W2 - h*S2*a1';
b2 = b2 - h*S2;
W1 = W1 - h*S1*p';
b1 = b1 - h*S1;

% Send p through the network again 
n1 = W1 * p + b1;
a1 = tansig(n1);
n2 = W2 * a1 + b1; 
a2 = logsig(n2);

% Compute new error 
E = sum((t-a2).^2);

% The error has decreased and we are ready to repeat the process 
















