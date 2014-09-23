function [t,y] = euler1(f,y0,t0,h,n)
%EULER OPGAVE 
t=t0;
y=y0;

antalskridt=h*n;

for j=1:h:antalskridt+1
    k1=f(t,y);
    y=y+h.*k1;
    t=t+h;
end 
    
end