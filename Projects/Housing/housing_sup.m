%% Tom Makkink
% Housing Fitting Problem 
% housing_sup
%---------------------------------------------------------------------------

clear 
close all 
clc 

%%
%------------------------------------------------
% Set up the data
%------------------------------------------------

load housing.mat
[r,q] = size(p);
% Network architecture 
% Layer sizes (multiples of 6 from 5 to 30)
S = [1:6];

% Matrix to store R^2 coefficients on test set 
rSquaredMatrix = zeros(6,7);
% Matrix to store the correlation coefficients on test set
corrCoefsMatrix = zeros(6,7);

% Fill both the first columns of the two matrices 
% with multiples of 5
rSquaredMatrix(:,1) = [5;10;15;20;25;30];
corrCoefsMatrix(:,1) = [5;10;15;20;25;30];

%%
%------------------------------------------------
% Propogate the net
%------------------------------------------------

for i=1:size(S,2)
    % Neurons in the first layer
    s1 = 5*S(i);
    
    for j=1:6
        s2 = j*5;
    
        % Create the net 
        net = newff(p,t,[s1,s2]);

        % training 
        net.trainFcn = 'trainscg';

        % maxit 
        net.trainParam.epochs=100;

        %set the number of epochs that the error on the validation set increses
        net.trainParam.max_fail=20;

        %We can also set using:
        [ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
        [ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

        %initiate
        net=init(net);

        % train 
        [net,netstruct] = train(net,p,t);

        % name the net and the stucture 
        net.userdata = 'housing';
        housingnet = net;
        housingstruct = netstruct;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        q1=size(ptrain,2);

        %using our own hand-made net:
        q2=size(ptest,2);

        %simulate
        atrain=sim(housingnet,ptrain); %train
        atest=sim(housingnet,ptest); %test
        a=sim(housingnet,p); %all  
        
        % store the r^2 stastic 
        r2 = rsq(ttest,atest);
        rSquaredMatrix(j,i+1) = r2;
        
        % store the correlation coefficient 
        [R,PV]=corrcoef(ttest,atest);
        corrCoefsMatrix(j,i+1) = R(1,2);   
    end 
%------------------------------------------------
end

%%
%------------------------------------------------
% Displaying the results 
%------------------------------------------------

%test:
disp('    Correltation coefficients on the test set')
disp('')
disp('s1/s2   5   10   15   20   25   30')
corrCoefsMatrix

disp('     R^2 Statistic on the test set')
disp('')
disp('s1/s2   5   10   15   20   25   30')
rSquaredMatrix   

%%
%------------------------------------------------
% Simulate net on best combination of layers
%------------------------------------------------
% Isolate relevant data by excluding first column 
rSquaredMatrix = rSquaredMatrix(:,[2:end]);
[M,I] = max(rSquaredMatrix(:));
[row col] = ind2sub(size(rSquaredMatrix),I);

disp('Optimum number of neurons in layer s1')
s1 = col*5
disp('Optimum number of neurons in layer s2')
s2 = row*5

% Create a new net with the best combination of layers 
net = newff(p,t,[s1,s2]);

% name the net and the stucture 
net.userdata = 'housing';
housingnet = net;
housingstruct = netstruct;

% Save the variables    
save housing_sup.mat housingnet   
    
    
    
