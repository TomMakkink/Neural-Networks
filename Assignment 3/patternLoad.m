function a = patternLoad(p)
% Activates using weights from pattern2 

load patterns2.m
a1 = hardlim(w1*aug(p));
a = hardlim(w2*aug(a1));
