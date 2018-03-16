% Tom Makkink
% Exercise 2.5.1
% Finding a suitable W and b
%---------------------------------------------------------------------------
clc
clear
close all

% Input pattern to be classified 
P = [1 -1 0; 2 2 -1];
T = [1 0 0];

% Initiate the weight and the bias randomly 
W = [rand(), rand()];
b = rand();
%W = [0.3443 0.6762];
%b =-0.9607;

N = W*P+b;
A = hardlim(N);
Error = T-A;
count = 0;

%Add the values to WW, bb and AA
WW = W;
bb = b;
AA = A;

% Stop when the A matches t, Or the net runs more than 100 times 
count = 0;

while (count < 100 && sum(Error.^2)>0)
    Q =P';
    dW = Error*P';
    db =sum(Error);
    W = W + dW;
    b = b + db;
    N = W*P+b;
    A = hardlim(N);
    
    count = count + 1;
    Error = T-A;
    
    % Record the weightes, biases and activation
    WW = [WW; W];
    bb = [bb; b];
    AA = [AA; A];
end

% Associate symbols with 0 and 1 values
M=P(:,A==1);
O=P(:,A==0);

x= -10:.01:10;
y= (-b-W(1)*x)/W(2);

close all

% Print Weights, Biases, Activation and Target 
fprintf('The sequence of weight matrices, biases and activations is \n WW = \n');
disp(WW);
fprintf('bb =  \n');
disp(bb);
fprintf('AA =  \n');
disp(AA);
fprintf('The final weight matrix is \n W = \n')
disp(WW(end,:))
fprintf('The final activation is \n A = \n')
disp(AA(end,:))
fprintf('The target was \n T = \n')
disp(T);

%Plot 1's as dots and 0's as circles
hold on 
plot(M(1,:),M(2,:),'.','markersize',12)
plot(O(1,:),O(2,:),'o')

%plot the decision boundary 
plot(x,y)
axis tight 

xlabel('x')
ylabel('y')
hold off


