function [ xfp ] = FPI(f,x0,k )
% We try to compute aprox. of f(x) = x (Fixed point iteration).

% We need a function handle, a starting guess, and some number of
% iterations k

x(1)=x0;
for i=1:k;
    x(i+1)=f(x(i));
    % proever at printe lortet ud saa vi kan see det gaar ikke saa godt
    %[ a, b ] = [i, x(i+1)]
end
xfp=x(k+1);


end

