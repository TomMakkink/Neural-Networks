%% Tom Makkink
% Engine fitting Network 
% Engine_sim
%---------------------------------------------------------------------------

clc 
clear all
close all 
load engine.mat

%%
%----------------------------------------------------------------------
% Load the data 
%----------------------------------------------------------------------
[P, T] = engine_dataset;
p = P'; 
t = T'; 

% Find Max 
pMax = max(p); 

% Find Min 
pMin = min(p); 

% Find Mean
pMean = mean(p); 


%%
%----------------------------------------------------------------------
% Vary the Speed and Fuel Rate 
%----------------------------------------------------------------------
% Fix the fuel rate, vary the speed
varySpeed(1,:) = repmat(pMean(2), 1, 1200);
varySpeed(2,:) = linspace(pMin(1), pMax(1), 1200); 

% Fix the speed, vary the fuel rate 
varyFuel(1,:)  = linspace(pMin(2), pMax(2), 1200); 
varyFuel(2,:)  = repmat(pMean(1), 1, 1200); 

%%
%----------------------------------------------------------------------
% Simulate on the network 
%----------------------------------------------------------------------
speedNet = sim(engineNet, varySpeed); 
fuelNet  = sim(engineNet, varyFuel);

%%
%----------------------------------------------------------------------
% Plot
%----------------------------------------------------------------------
% Speed vs Torque
figure 
plot(varySpeed(2,:), speedNet(1,:)); 
title('Speed vs Torque'); 
xlabel('Speed');
ylabel('Torque');

% Speed vs Nitrous oxide emissions 
figure 
plot(varySpeed(2,:), speedNet(2,:)); 
title('Speed vs Nitrous Oxide Emissions');
xlabel('Speed'); 
ylabel('Nitrous Oxide Emissions'); 

% Fuel Rate vs Torque 
figure 
plot(varyFuel(1,:), fuelNet(1,:)); 
title('Fuel Rate vs Torque'); 
xlabel('Fuel Rate');
ylabel('Torque');

% Fuel Rate vs Nitrous Oxide Emissions
figure 
plot(varyFuel(1,:), fuelNet(2,:)); 
title('Fuel Rate vs Nitrous Oxide Emissions'); 
xlabel('Fuel Rate');
ylabel('Nitrous Oxide Emissions');














