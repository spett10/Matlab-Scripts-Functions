function [] = Eulerp336b(y,h,t)
%Euler Method as solver for exercise 1 p 336 saul12
%
table=zeros(2,20000);
w = y;
k=1;

%given: y' = y^2 - y^3
%equilibrium at y = 1
%df/dy = 2y - 3y^2, at 1 this is -1, so stiff, but not much

%wi+1 = wi + hf(ti,wi) = wi + h(wi^2+wi^3)

while t<20
w = w+h*(6*w-6*w^2); %euler method. 
tabel(1,k)=t;
tabel(2,k)=w;
k=k+1;
t=t+h; %static stepsize. 
end
tabel(:,k:end)=[];
plot(tabel(1,:),tabel(2,:))
end