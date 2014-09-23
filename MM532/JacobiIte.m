function[x] = JacobiIte(A,B,x0,max,tol)
%Søren Elmely Pettersson & Lasse Melbye 
%For solving linear system, Ax=b
%x0 is inital guess
%USAGE:
%call with upright vectors, i.e if x0 is [1, 1, 1], call with 
%transposed, i.e. x'

size=length(B);%dimension of B, what to iterate over for i.
t=0;%number of steps, compare to max (precaussion if we never converge)
while t<max
    for i=1:size
    x(i)=(1/(A(i,i))).*(B(i)-dot(A(i,[1:i-1, i+1:end]),x0([1:i-1, i+1:end])));
    end
    t=t+1;
    fejl=abs(norm(x'-x0));
    x0=x';%ready for next step (if there will be one)
      if (fejl<tol)
        break %if within the tol, no reason to iterate any further
      end
end
x=x';%transpose back
end

