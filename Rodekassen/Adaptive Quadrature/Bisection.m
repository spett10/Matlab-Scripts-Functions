function [ a,b ] = Bisection(f,a,b,tol)
%finds zero of f in [a,b] with accuracy TOL
%Usage: E.g.  
%format long
%f=@(x) x^3-5
%[a b]=Bisection(f,-5,2,1e-10)
fa=f(a);
fb=f(b);
%i = 1;
if fa==0
    b=a;
elseif fb==0
    a=b;
elseif fa*fb>0
    error('Inappropriate use');
else
    while b-a>tol
        m=(b+a)/2;
        fm=f(m);
        if fm==0
            a=m;
            b=m;
            %i = i+1;
        elseif fa*fm<0
            b=m;
            %i = i+1;
        else
            a=m;
            fa=fm;
            %i = i+1;
        end
    end
end
%disp(i);

