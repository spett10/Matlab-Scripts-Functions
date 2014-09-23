function [] = BackEulerp336b(y,h, t)
%Backward Euler Using Newton Method as solver for exercise 1 p 336 saul12
% part b
table=zeros(3,20000);
w = y;
k=1;

%given: y' = 6y - 6y^2
%equilibrium at y = 1
%df/dy = 6 - 12y, at 1 this is -6, so stiff!

%wi+1 = wi + hf(ti+1, wi+1) = wi + h(6 - 12wi+1)

%replace z = wi+1
%solve for z, we obtain z + h12z - h6 - wi  = 0 

while t<20
z = w;
for i=0:1:10 %solve for z using newton
z = z - ((z+h*12*z-h*6-w)/(1+h*12));
i=i+1;
end
w = w+h*(6-12*z); %backwards euler. 
tabel(1,k)=t;
tabel(2,k)=w;
tabel(3,k)=z;
k=k+1;
t=t+h; %static stepsize. 
end
tabel(:,k:end)=[];
plot(tabel(1,:),tabel(2,:))
end
