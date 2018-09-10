% Tom Makkink
% Exercise 5.4.2 (9)
% Batch Training 
%---------------------------------------------------------------------------

clc 
clear all
close all 

%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
Data = importdata('riskdata.txt');
p = Data(:, 1:4);

% Maxima 
pM = max(p);

% Minima
pm = min(p);

% Average 
a = mean(p);

%--------------------------------------------------------------------
% Vary the age
%--------------------------------------------------------------------

% age
xA(1,:)=linspace(pm(1),pM(1));

% BMI/BP
xA(2,:)=repmat(a(2),1,100);

% genetic history
xA(3,:)=repmat(a(3),1,100);

% fitness level
xA(4,:)=repmat(a(4),1,100);

%--------------------------------------------------------------------
% Vary the BMI
%--------------------------------------------------------------------
xB (1,:)= repmat(a(1), 1, 100);
xB (2,:)= linspace(pm(2),pM(2));
xB (3,:)=repmat(a(3),1,100);
xB (4,:)=repmat(a(4),1,100);

%--------------------------------------------------------------------
% Vary the genetic history
%--------------------------------------------------------------------
xG(1,:)= repmat(a(1), 1, 100);
xG(2,:)= repmat(a(2), 1, 100);
xG(3,:)= linspace(pm(3),pM(3));
xG(4,:)=repmat(a(4),1,100);


%--------------------------------------------------------------------
% Vary the fitness
%--------------------------------------------------------------------
xF(1,:)= repmat(a(1), 1, 100);
xF(2,:)= repmat(a(2), 1, 100);
xF(3,:)= repmat(a(3), 1, 100);
xF(4,:)= linspace(pm(4),pM(4));

%--------------------------------------------------------------------
% Deploy network 
%--------------------------------------------------------------------
yA = risknet(xA);
yB = risknet(xB);
yG = risknet(xG);
yF = risknet(xF);

%--------------------------------------------------------------------
% Plot
%--------------------------------------------------------------------
% Fixed age
figure 
plot(xA(1,:), yA);
xlabel('Age');
ylabel('Risk');
title('RISK VS AGE');

% Fixed BMI/BP
figure 
plot(xB(2,:),yB);
xlabel('BMI/BP');
ylabel('Risk');
title('RISK VS BMI/BP');

% Fixed Genetic history 
figure 
plot(xG(3,:), yG);
xlabel('Genetic history');
ylabel('Risk');
title('RISK VS GENETIC HISTORY');

% Fixed Fitness 
figure 
plot(xF(4,:), yF);
xlabel('Fitness');
ylabel('Risk');
title('RISK VS FITNESS');



















