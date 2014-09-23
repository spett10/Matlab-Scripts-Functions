function [] = opgave4(f,g,x0,y0,t0,h,n)
%euler på et ligningssystem af 2 differentialligninger
%opgave 1 side 201, implementering af side 198.
% x0, y0, t0 er startværdier
% n er antal iterationer
% h er skridtlængden pr iteration
k=@(t) 0.1*sin(t)-0.25*cos(3*t)-0.3*sin(7*t)+0.5*cos(13*t);
tid=linspace(0,10,100);

t=t0;
y=y0;
x=x0;

antalskridt=h*n;

tabel=zeros(3,n);
tabel(:,1)=[t0;x0;y0];

i=2;

for j=1:h:antalskridt+1
    k1=f(t,x,y);
    k2=g(t,x,y);
    x=x+h*k1;
    y=y+h*k2;
    %forbedret euler er således:
    %x=x+((k2+f(t+h,x+h*k2,y+h*k1))/2)*h;
    %y=y+((k1+g(t+h,x+h*k2,y+h*k1))/2)*h;
    t=t+h;
    tabel(3,i)=y;
    tabel(2,i)=x;
    tabel(1,i)=t;
    i=i+1;
end
    plot(tabel(1,:),tabel(3,:),'r')
    hold on
    plot(tabel(1,:),tabel(2,:),'g')
    hold on
    plot(tid,k(tid),'b')
end



