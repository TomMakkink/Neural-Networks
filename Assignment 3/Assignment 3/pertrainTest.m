% pertrain.m 
function w = pertrainTest(p,t)
% W includes the bias in the last column 

% Check the matrices are the correct sizes 
[r,m] = size(p);
[s,mt]= size(t);

if m ~= mt 
    error('Number of input targets does not match number of targets');
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% architecture: s hardlim neurons 
% s is the dimension of the target vector 
% 
% w * p + b ----------------> a
%sxr  rx1 sx1                sx1
%
% or 
% [W b]*aug(p) -------------> a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initiate weight with bias in the last column 
w = [randu(0,1,s,r+1);randu(0,1,s,r+1)]

p = aug(p);

% Activation 
a = hardlim(w*p);

% Error vector 
e = t-a

% Iterations counter 
k = 0;
maxit = 100;

% perceptron training 
while any(any(e)) ~= 0 & k < maxit 
    k=k+1;
    dw = e*p';
    w = w + dw;
    e = t - hardlim(w*p);
    
    if k > maxit 
        error('maxit reached')
    end 
end 

if any(e) 
    error('Did not converge')
end 
















