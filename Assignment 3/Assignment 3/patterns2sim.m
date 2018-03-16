function a = patterns2sim (p)
% simulates on many inputs using patterns2

[a,w1] = patternLoad(p);
close all
figure
hold on 
% Plot the decision boundaries 
plotdb(w1(1,:),p)
plotdb(w1(2,:),p)
plot(p(1,a==1),p(2,a==1),'x','markersize',15);
plot(p(1,a==0),p(2,a==0),'o');
axis([0,1,0,1]);
hold off

end