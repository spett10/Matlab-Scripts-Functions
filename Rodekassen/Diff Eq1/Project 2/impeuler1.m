function [] = impeuler1(f,y0,t0,h,n)
%improved euler 
t=t0;
y=y0;

udprint= zeros(2,n);
udprint(:,1)=[t0;y0];

i=1;

antalskridt=h*n;

for j=1:h:antalskridt+1
    k1=f(t,y);
    y=y+((k1+f(t+h,y+h*k1))/2)*h;
    t=t+h;
    udprint(2,i)=y;
    udprint(1,i)=t;
    i=i+1;
end 
    udprint
end
