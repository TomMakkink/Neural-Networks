function [p t]=delay(x,r)
%produces a moving window of length r from the sequence x
%from x1 x2 x3 ..........
%produces
%p=
%x1   x2             x(n-r)
%x2
%
%xr   x(r+1)         x(n-1)

%t=
%x(r+1)              xn
n=size(x,2);
for k=1:n-r
    p(:,k)=x([k:k+r-1]);
    t(k)=x(k+r);
end