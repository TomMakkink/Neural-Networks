% Gradient function 
function gv = gr(p)
M = p(1);
k = p(2);
t = [0:10];
y = [0 2.67 -2.32 -0.80 2.98 -1.55 -1.61 2.83 -0.86 -2.35 2.87];

gv(1) = sum(2*(M.*sin(k.*t) - y).*(sin(k.*t)));
gv(2) = sum(2*(M.*sin(k.*t) - y) .*(M.*t.*cos(k.*t)));
gv = gv(:);
return 