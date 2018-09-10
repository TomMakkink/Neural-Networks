% Momentum example 

% 1) Organise p, t with examples as columns 

% 2) Define the training and test sets 
% test index 
m = size(p,2);                  % Length of the second dimension of p
ti = [1:3:m];

% training index
tri = setdiff([1:m], ti);

% training and test sets 
ptrain = p(:, tri);
ttrain = t(:, tri);
ptest = p(:, ti);
ttest = t(:, ti);

% Decide on the network architecture 


% Initialise by forming six books with the first weight matrices and biases
% on the first page 
k = 1; 
% initialise
W1(:,:,k) = randu(-1,1,s1,r);
b1(:,:,k) = randu(-1,1,s1,1);
W2(:,:,k) = randu(-1, 1, s2, s1);
b2(:,:,k) = randu(-1, 1, s2, 1);
W3(:,:,k) = randu(-1, 1, s3, s2);
b3(:,:,k) = randu(-1, 1, s3, 1); 

% set the learning rate and momentum 
% learning rate 
r = .005;

% Momentum 
q = .25;

% Define f1, f2, f3 
f1 = @tansig;
f2 = @logsig;
f3 = @purelin;

% Scale down and obtain an error on the first epoch 
m1 = size(ptrain, 2);

% normalised data for training 
%pn = ptrain normalised;
%tn = ttrain normalised;

% Obtain error for first epoch 
for j=1:m1
    n1 = W1(:,:,k)*pn(:,j)+b1(:,:,k);
    a1 = f1(n1);
    n2 = W2(:,:,k)*a1+b2(:,:,k);
    a2 = f2(n2);
    n3 = W3(:,:,k)*a2+b3(:,:,k);
    a3 = f3(n3);
    % Jth error vector 
    E(j) = sum((tn(:,j)-a3).^2);
end 

% Error for the first epoch 
E = sum(E.^2);
EE = [E];

% Back proagate.
d3=size(a3,1);
d2=size(a2,1);
d1=size(a1,1);

f3dot=eye(d3);
f2dot=diag((1-a2).*a2);
f1dot=diag(1-a1.^2);

s3=-2*f3dot*(tn(:,j)-a3);
s2=f2dot*W3(:,:,k)'*s3;
s1=f1dot*W2(:,:,k)'*s2;

%first update
W3(:,:,k+1)=W3(:,:,k)-r*s3*a2';
b3(:,:,k+1)=b3(:,:,k)-r*s3;

W2(:,:,k+1)=W2(:,:,k)-r*s2*a1';
b2(:,:,k+1)=b2(:,:,k)-r*s2;

W1(:,:,k+1)=W1(:,:,k)-r*s1*pn(:,j)';
b1(:,:,k+1)=b1(:,:,k)-r*s1;

% set tolerance 
tol = 1e-6;

k = 2;

while E>tol & k<500
    %run the batch
    for j=1:m1
        n1=W1(:,:,k)*pn(:,j)+b1(:,:,k);
        a1=f1(n1);
        
        n2=W2(:,:,k)*a1+b2(:,:,k);
        a2=f2(n2);
        
        n3=W3(:,:,k)*a2+b3(:,:,k);
        a3=f3(n3);
        
        %error for j th pattern
        E(j)=sum((tn(:,j)-a3).^2);
        
        d3=size(a3,1);
        d2=size(a2,1);
        d1=size(a1,1);
        
        f3dot=eye(d3);
        f2dot=diag((1-a2).*a2);
        f1dot=diag(1-a1.^2);
        
        s3=-2*f3dot*(tn(:,j)-a3);
        s2=f2dot*W3(:,:,k)'*s3;
        s1=f1dot*W2(:,:,k)'*s2;
        
        % Update with momentum 
        W3(:,:,k+1) = W3(:,:,k) - r*s3*a2' + q*(W3(:,:,k) - W3(:,:,k-1));
        b3(:,:,k+1) = b3(:,:,k) - r*s3 + q*(b3(:,:,k) - b3(:,:,k-1));
        
        W2(:,:,k+1)=W2(:,:,k)-r*s2*a1'+q*(W2(:,:,k)-W2(:,:,k-1));
        b2(:,:,k+1)=b2(:,:,k)-r*s2+q*(b2(:,:,k)-b2(:,:,k-1));
        
        W1(:,:,k+1)=W1(:,:,k)-r*s1*pn(:,j)'+q*(W1(:,:,k)-W1(:,:,k-1));
        b1(:,:,k+1)=b1(:,:,k)-r*s1+q*(b1(:,:,k)-b1(:,:,k-1));
    end 
    
    % error for the epoch 
    E = sum(E.^2);
    EE = [EE;E];
    
    % Update 
    k = k + 1;
    
end 

% 10) Plot the performance and obtain the final weights and biases
% Plot error (performance function) 
close all 
plot(EE);
xlabel('epochs')
ylabel('error')

title(sprintf('Performance with \n LR=%5.4f and Momentum = %5.4f\n epoochs = %d', r, q, k))

% Display erros 
format long 
epochs = [1:k-1]
errors = EE(:)';
printout = [epochs; errors];
fprintf('epoch: %d error: %16.15f\n', printout);
% disp(EE(:))

W3=W3(:,:,end);
W2=W2(:,:,end);
W1=W1(:,:,end);
b3=b3(:,:,end);
b2=b2(:,:,end);
b1=b1(:,:,end);

% Save the variables so that weights and biases can be used on other data 

        









