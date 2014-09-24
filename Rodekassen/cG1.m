function [] = cG1(fhandle,u0,t0,h,a,realfhandle)
%usage: fhandle is rhs of u'+au=f
%       u0 is initial value
%       h is stepsize (static)
%       a is a (constant)
%       realfhandle is real solution, which will be plottet in red


%initialize
tabel=zeros(2,20000);%make tabel first, instead of dynamically
i=2;
un=u0;
tabel(2,1)=t0;
tabel(1,1)=u0;

%since trap is exact for linear:
%u_n - u_{n-1} + a\frac{u_{n-1}+u_n}{2}\Delta t =
%\int_{t_{n-1}}^{t_n} f dt
%Isolating u_n gives the iterative step for the interval (t_n,t_n-1):
%(1 + a \Delta t /2) u_n = (1 - a \Delta t /2)u_{n-1}+\int .. dt

for t=0:h:1%stepsize is input and static, should sum to T=1 (non-addapting)
un=((1-(a.*(t-tabel(2,i-1)))./2).*tabel(1,i-1)
+adapquad(fhandle,tabel(2,i-1),t,0.001))./(1+(a.*(t-tabel(2,i-1)))/2);
tabel(1,i) = un;
tabel(2,i) = t;
i=i+1;
end
tabel(:,i:end)=[];%reduce tabel size
plot(tabel(2,:),tabel(1,:))
hold on
%plotting real solution
v=[t0:h:tabel(2,i-1)];
plot(v,realfhandle(v),'g--')
end