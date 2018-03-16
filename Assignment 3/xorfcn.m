function a = xorfcn(p)
% Activates using weights from XORexample 

load xorprob.m
a1 = hardlim(w1*aug(p));
a=hardlim(w2*aug(a1));

