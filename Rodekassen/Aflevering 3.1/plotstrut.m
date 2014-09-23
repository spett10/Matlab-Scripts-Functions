function [ ] = plotstrut(x,y,theta)
%after we obtain the x and y values, we wish to plot the specific pose
%we will first calculate the other vertices for our platform, and
%afterwards we simply plot them. 

%we take all our neccesary global variables, and compute A2,A3,B2,B3
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

%we calculate the vertices
u1=x;
v1=y;
u2=x+L2.*cos(theta);
v2=y+L3.*sin(theta);
u3=x+L2.*cos(theta+gamma);
v3=y+L2.*sin(theta+gamma);

%we calculate the struts ourselves
cp1=sqrt(x^2+y^2);
cp2=sqrt((x+A2).^2+(y+B2).^2);
cp3=sqrt((x+A3).^2+(y+B3).^2);


%we plot the vertices
plot([u1 u2 u3 u1],[v1 v2 v3 v1],'r'); hold on
%we plot the anchor points
plot([0 x1 x2],[0 0 y2],'bo')
%we plot the struts
plot([0 u1],[0 v1])
plot([x2 u3],[y2 v3])
plot([x1 u2],[0 v2])

end