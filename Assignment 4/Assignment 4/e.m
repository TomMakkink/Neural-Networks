% error functio 
function E = e(M,k)
t = [0:10];
y = [ 0 9.38 18.67 26.14 31.8 37.68 47.35 47.92 55.49 60.82 65.62];
E = sum( rf(t,M,k) - y).^2;
return 