function [ ] = Brownian( )
stepsize=1/500;
path=1000;
steps=1/stepsize;
x=zeros(path,steps);
t=x;
for i=2:1:steps+1
   x(:,i) = x(:,i-1)+randn(path,1)*sqrt(stepsize);
   t(:,i) = t(:,i-1)+ones(path,1)*stepsize;
end
u=exp(1/2*x+t);
plot(t(1,:),mean(u,1));
hold on
plot(t(1,:),u(1:5,:));
end

