% Tom Makkink
% Exercise 2.5.1
% Finding a suitable W and b
%---------------------------------------------------------------------------
clc
clear
close all

% Train the Perceptron once
trainPerceptron();
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








