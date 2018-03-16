% Tom Makkink
% Exercise 2.6.1
% Returning a Weight,bias and number of iterations 
%---------------------------------------------------------------------------
clc
clear
close all

% Prompt for P, T, and max iterations 
% P = input('P = ');
% T = input('T = ');
maxI = input('Max iterations = ');

% Generate a P and T 
[P, T] = per2gen();
P = [P; ones(1,size(P,2))];

% Train the Perceptron once
[W, b, I] = trainPerceptronPerl2(P, T, maxI);
while (true)
    fprintf('Classify another point? 1=yes, 0=no\n');
    a = (input('a = '));
    if (a == 1)
        trainPerceptronPerl2(P, T, maxI);
    end
    if (a == 0)
        return 
    end
end