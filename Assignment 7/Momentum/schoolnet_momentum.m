% Tom Makkink
% Exercise 5.4.2 (1)
% schoolnet
%---------------------------------------------------------------------------
function y= schoolnet_momentum(x)

load('school_mom.mat')

if size(x,1)~=r
    error('x incorrect size');
end

%normalise x (scale down)
xn=Dp*x+repmat(pc,1,size(x,2));

%propogate through network
for j=1:size(x,2)
    n1=W1(:,:,k)*xn(:,j)+b1(:,:,k);
    a1=f1(n1);
    
    n2=W2(:,:,k)*a1+b2(:,:,k);
    a2=f2(n2);
   
    yn(:,j)=a2;
end


%scale data up
 y= diag(1./tf)*(yn-repmat(tc,1,size(yn,2))); 