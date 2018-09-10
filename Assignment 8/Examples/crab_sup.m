%% Tom Makkink
% Exercise 6.1.3 (2)
% Crab Classification Problem 
%---------------------------------------------------------------------------

clc 
clear all
close all 

load crab_dataset.mat
[p,t] = crab_dataset;
[r,q] = size(p);


% Network architecture 
% Layer sizes 
S = [1:10];
S2 = [1:10];

% matrix to store assessments 
A = zeros(size(S,1),3);

row = 1;

for i=1:size(S,2)
    s1 = S(i);
    for k=1:size(S2,2)
       
        s2 = k;

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
        net.userdata = 'crabs';
        crabnet = net;
        crabstruct = netstruct;

        %simulate
        atrain=sim(crabnet,ptrain); %train
        atest=sim(crabnet,ptest); %test
        a=sim(crabnet,p); %all

        %--------------------------------------------------
        %assessing the degree of fit
        %--------------------------------------------------
        A(row,1) = s1;
        A(row,2) = s2;
        
        %test:
        r2=rsq(ttest,atest);
        A(row,3)=r2(1);
        
        % Convert activations into a 1 or 0
        atest = hardlims(atest);
        atest = [atest(1,:)==1;atest(2,:)==1];
        
        % Calculate number of correct classifications 
        numcorrect = sum(atest==ttest);
        numcorrect = sum(numcorrect==2);
        
        % Calculate percentage of correct classifications 
        pc = (numcorrect/length(ttest))*100;
        A(row,4) = pc;
        row = row + 1;
    end
end 
disp('        s1        s2        r2        %');
A

% Find the best S1 and S2 combination 
[m,index] = max(A(:,4));
S1_best = A(index,1)
S2_best = A(index,2)

% Save the variables 
save sup_crab.mat S1_best S2_best

