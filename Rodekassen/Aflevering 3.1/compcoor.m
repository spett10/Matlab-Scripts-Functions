function [ z ] = compcoor(theta)
%we obtain our x and y coordinate from the roots of our f(theta) function
%by using Bisection.m on the intervals we deduced from the plot of f(theta)
% on the interval of -pi to pi.
%We check wether our calculated struts, cp1, cp2, cp3 match the given 
% struts p1,p2,p3 to verify our answers (this is done by disp(x) them and
%and just comparing them by the given constants from the assignment).

% afterwards, we calculate the vertices, and plot the given pose.

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

%we now calculate x and y for this given pose.

x=N1./D;
y=N2./D;
z = [x y];

%we now calculate the struts from our newfound x and y values
cp1=sqrt(x^2+y^2)
cp2=sqrt((x+A2).^2+(y+B2).^2)
cp3=sqrt((x+A3).^2+(y+B3).^2)

%we calculate the vertices
u1=x;
v1=y;
u3=x+L2.*cos(theta);
v3=y+L3.*sin(theta);
u2=x+L2.*cos(theta+gamma);
v2=y+L2.*sin(theta+gamma);

%we plot the vertices
plot([u1 u2 u3 u1],[v1 v2 v3 v1],'r'); hold on
%we plot the anchor points
plot([0 x1 x2],[0 0 y2],'bo')
%we plot the struts
plot([0 u1],[0 v1])
plot([x2 u3],[y2 v3])
plot([x1 u2],[0 v2])

end

