% Tom Makkink
% Exercise 6.1.3 (1)
% Housing_sim
%---------------------------------------------------------------------------

clc 
clear all
close all 

%%
% Import the data 
Data = importdata('pnew.txt');

% simulate on the network 
a = housing_fcn(Data);

disp('Activations:');
fprintf('    %4.2f',a);
