function a = patterns2sim (p)
% simulates on many inputs using patterns2

a = patternLoad(p);
close all
figure
hold on 
plot(p(1,a==1),p(2,a==1),'.','markersize',15);
plot(p(1,a==0),p(2,a==0),'o');
axis([0,1,0,1]);
hold off

end