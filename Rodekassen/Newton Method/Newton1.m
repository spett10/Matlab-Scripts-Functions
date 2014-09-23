function [ z ] = Newton(f,fprime,x0,k)
%NEWTON We try to use newton's method.

%find derivative by hand, so we just need the 
%function handle for f and the derivative, a starting value, and a number of iterations

%fprime = diff(f);
x(1) = x0;
for i=1:k;
    x(i+1) = x(i) - (f(x(i))./(fprime(x(i))));
end
z=f(k+1);

end

