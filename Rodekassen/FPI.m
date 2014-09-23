function x = FPI(f,x0,tol,k,fp)
% Compute approximation to f(x)=x
iter=0;
x=x0;
done=false;
if nargin>4
    fpcheck=true;
    e=norm(x-fp,1);
    xOutput=length(x)==1;
else
    fpcheck=false;
end
while (iter<k) && ~done
    xold=x;
    x=f(x);
    done=norm(x-xold,1)/max(norm(x,1),1)<tol;
    iter=iter+1;
    if fpcheck
        eold=e;
        e=norm(x-fp,1);
        if xOutput
            fprintf('%2i | %.10f |%.10f |%.10e |%.10f |%.10f \n',iter,xold,x,e,e/eold,e/eold^2)
        else
            fprintf('%2i |%.10e |%.10f |%.10f \n',iter,e,e/eold,e/eold^2)
        end
    end
end
fprintf('\n Overall %i iterations',iter)