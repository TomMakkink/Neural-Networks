% Tom Makkink
% Exercise 6.1.3 (1)
% Risk_sim
%---------------------------------------------------------------------------

clc 
clear all
close all 

%----------------------------------------------------------------------
% Arrange the data 
%----------------------------------------------------------------------
Data = importdata('risk.txt');
P = Data(:,[1 2 3 4]);

% Find maxima of data 
pmax = max(P);
% Find minima of data
pmin = min(P);
% Find the average of data 
pave = mean(P);

%----------------------------------------------------------------------
% Vary the BMI
%----------------------------------------------------------------------
% BMI 
bmi(1,:) = linspace(pmin(1),pmax(1))
% Blood Pressure 
bmi(2,:) = repmat(pave(2),1,100);
% Age 
bmi(3,:) = repmat(pave(3),1,100);
% Fitness
bmi(4,:) = repmat(pave(4),1,100);

%----------------------------------------------------------------------
% Vary the Blood Pressure
%----------------------------------------------------------------------
% BMI 
bloodP(1,:) = repmat(pave(1),1,100);
% Blood Pressure 
bloodP(2,:) = linspace(pmin(2),pmax(2));
% Age 
bloodP(3,:) = repmat(pave(3),1,100);
% Fitness
bloodP(4,:) = repmat(pave(4),1,100);

%----------------------------------------------------------------------
% Vary the Age
%----------------------------------------------------------------------
% BMI 
age(1,:) = repmat(pave(1),1,100);
% Blood Pressure 
age(2,:) = repmat(pave(2),1,100);
% Age 
age(3,:) = linspace(pmin(3), pmax(3));
% Fitness
age(4,:) = repmat(pave(4),1,100);


%----------------------------------------------------------------------
% Vary the Fitness
%----------------------------------------------------------------------
% BMI 
fit(1,:) = repmat(pave(1),1,100);
% Blood Pressure 
fit(2,:) = repmat(pave(2),1,100);
% Age 
fit(3,:) = repmat(pave(3),1,100);
% Fitness
fit(4,:) = linspace(pmin(4),pmax(4));

%----------------------------------------------------------------------
% Deploy the network
%----------------------------------------------------------------------
bmiA = risk_fcn(bmi);
bloodPA = risk_fcn(bloodP);
ageA = risk_fcn(age);
fitA = risk_fcn(fit);

%----------------------------------------------------------------------
% Plot
%----------------------------------------------------------------------
% Fixed BMI
figure
plot(bmi(1,:),bmiA)
xlabel('BMI')
ylabel('risk')
title('RISK VS BMI')

% Fixed Blood Pressure 
figure
plot(bloodP(2,:),bloodPA)
xlabel('Blood Pressure')
ylabel('risk')
title('RISK VS BLOOD PRESSURE')

% Fixed Age
figure
plot(age(3,:),ageA)
xlabel('Age')
ylabel('risk')
title('RISK VS AGE')

% Fixed Fitness
figure
plot(fit(4,:),fitA)
xlabel('Fitness')
ylabel('risk')
title('RISK VS FITNESS')




















