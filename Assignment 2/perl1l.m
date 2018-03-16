% Tom Makkink
% Exercise 2.6.1
% Returning a Weight,bias and number of iterations 
%---------------------------------------------------------------------------
clc
clear
close all

% Train the Perceptron once
[W, b, I, r] = trainMultiNeuronPerceptronL();
run = true;
    while (run)
        fprintf('Classify another point? 1=yes, 0=no\n');
        a = (input('a = '));
        if (a == 1)
            trainPerceptron();
        end
        if (a == 0)
            return 
        end
    end 