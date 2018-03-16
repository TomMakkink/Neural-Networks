function [P,T] = per2gen()
% per2gen 
% generates pattern vectors in R^3 near the vertices 
% (0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)
clear all 
clc 

% vertices 
M = [[0;0;0] eye(3)];

% perturb 
for j=1:4
    N(:,:,j)= M + randu(-.2,.2,3,4);
end 

%Starting indices 
s = [1:4:13];

% Generate bloacks 
for j=1:4
    P(:,[s(j): s(j) + 3])=N(:,:,j);
end 

P
%targets 
T = repmat( [ [0;0;0] eye(3)],1,4)