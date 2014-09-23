function [X] = SteepestDescent(A,B,x0,max,tol)
%S�ren Elmely Pettersson & Lasse Melbye 
%use steepest descent to solve Ax = b
%x0 is inital guess
%remember, matrix dimensions must agree!

r=B-A*x0;
p=A*r;
X=x0;
t=0;
while tol<norm(r) && t<max
   alpha=dot(r,r)/dot(p,r);
   X=X+alpha.*r;
   r=r-alpha.*p;
   p=A*r;   
   t=t+1;
end
t %print number of iterations
end

