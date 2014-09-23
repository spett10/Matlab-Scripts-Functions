f=@(t) (-4)*((1-t).^(1/3)).*(exp(t)./3);
u=@(t) ((1-t).^(4/3)).*(exp(t));
u0=1;
a=-1;
%f=@(t) exp(-t);
%u=@(t) t.*exp(-t);
%u0=0;
%a=1;
resultscG1=zeros(3,15);
%stepsizes
for i=1:1:15
resultscG1(3,i)=2^(-(i+1));
end
%compute approximations
for k=1:1:15
resultscG1(1,k)=cG1(f,u0,0,resultscG1(3,k),a,u);
end
%compute error
for l=1:1:15
resultscG1(2,l)=abs(u(1)-resultscG1(1,l));    
end
%plot log of erros against log of steps 
scatter(log(resultscG1(3,:)),log(resultscG1(2,:)))
h=lsline;
%calculate the slope i.e the first component
%of the linear equation fitted to our datapoints
p=polyfit(get(h,'xdata'),get(h,'ydata'),1);
p(1)