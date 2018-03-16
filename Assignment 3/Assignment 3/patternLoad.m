function [a,w1] = patternLoad(p)
% Activates using weights from pattern2 

load patterns.mat
a1 = hardlim(w1*aug(p));
a = hardlim(w2*aug(a1));
