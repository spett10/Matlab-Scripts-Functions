function [f] = activity1(theta)
%activity1 for the kinematics of the stewart platform, Numerical Analysis T
%sauer 2.ed P. 71-73
%   Given our parameters for a given pose, we wish to obtain the roots of
%   f(theta) equal to zero. We only take theta as our argument, since this
%   is the only variabel, the other are given constants, which we utilize
%   as global variables.
%   We first initialize our neccesary values:

global L1
global L2
global L3
global gamma
global p1
global p2
global p3
global x1
global x2
global y2 

A2 = (L3.*cos(theta))-x1;
B2 = L3.*sin(theta);
A3 = (L2.*(cos(theta).*cos(gamma)-sin(theta).*sin(gamma)))-x2;
B3 = (L2.*(cos(theta).*sin(gamma)+sin(theta)*cos(gamma)))-y2;
D = 2.*(A2.*B3-B2.*A3);

N1 = B3.*((p2.^2)-(p1.^2)-(A2.^2)-(B2.^2))-B2.*((p3.^2)-(p1.^2)-(A3.^2)-(B3.^2));
N2 = -A3.*((p2.^2)-(p1.^2)-(A2.^2)-(B2.^2))+A2.*((p3.^2)-(p1.^2)-(A3.^2)-(B3.^2));

%given our constants, we can calculate the roots of our f, and we return
%the function value:

f = (N1.^2)+(N2.^2)-((p1.^2)*(D.^2));

end

