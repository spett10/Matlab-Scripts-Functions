function [] = BackEulerp336(y,h, t)
%Backward Euler Using Newton Method as solver for exercise 1 p 336 saul12
%
table=zeros(3,20000);
w = y;
k=1;

%given: y' = y^2 - y^3
%equilibrium at y = 1
%df/dy = 2y - 3y^2, at 1 this is -1, so stiff, but not much

%wi+1 = wi + hf(ti+1, wi+1) = wi + h(2wi+1 - 3wi+1^2)

%replace z = wi+1
%solve for z, we obtain z + h3z^2 - h2z - wi = 0 

while t<20
z = w;
for i=0:1:10 %solve for z using newton
z = z - ((z+h*3*z^2-h*2*z-w)/(1+6*h*z-h*z));
i=i+1;
end
w = w+h*(2*z-3*z^2); %backwards euler. 
tabel(1,k)=t;
tabel(2,k)=w;
tabel(3,k)=z;
k=k+1;
t=t+h; %static stepsize. 
end
tabel(:,k:end)=[];
plot(tabel(1,:),tabel(2,:))
end

