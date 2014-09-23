function [  ] = p2tester( strut )
% For some value of the strut p2, we plot f(theta) against theta to see
% if there are any roots - trial and error to find intervals for different
% amount of poses
global p2
p2=strut;
theta=-pi:0.01:pi;
f=activity1(theta);
plot(theta,f)

end

