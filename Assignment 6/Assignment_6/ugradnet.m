function y=ugradnet(x)

load('ugrad_train.mat')

if size(x,1)~=r
    error('x incorrect size');
end

%normalise x (scale down)
xn=Dp*x+repmat(pc,1,size(x,2));

%propogate through network
for j=1:size(x,2)
    n1=W1*xn(:,j)+b1;
    a1=f1(n1);
    
    n2=W2*a1+b2;
    a2=f2(n2);
    
    n3=W3*a2+b3;
    a3=f3(n3);
    yn(:,j)=a3;
end


%scale data up
 y= diag(1./tf)*(yn-repmat(tc,1,size(yn,2)));
