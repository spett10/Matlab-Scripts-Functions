function [] = RK23(fhandle,t,w,h)
%lav tabel så du kan plotte til sidst!
tabel=zeros(3,20000);
%tabel(:,1)=[0;w;]
i=1;

%RK23 Saul12 p 332, section 6.5. nr.1
tol=10^(-8);
%we start at [0,1]. 
hmax=h;
hmin=h;
%for (j=0:h:1)
while (t<1)
%keep track of the values from previous step, if we need
% to recalculate this step, if error > tol.
wold=w;
told=t;
s1=fhandle(t,w);
s2=fhandle(t+h,w+h*s1);
s3=fhandle(t+0.5*h, w+0.5*h*((s1+s2)/2));
w = RK2(w,h,s1,s2);
z = RK3(w,h,s1,s2,s3);

error=abs(h*((s1-2*s3+s2)/3));
%compare error estm. for this step
%if the error is below tol, set next step accordingly
if ((error/abs(w))<tol)
    h=0.8*(((tol*abs(w))/error)^(1/3))*h; %if error zero
                                           %we get inf! 
    %keep track of biggest step size
    if (h>hmax)
        hmax=h;
    elseif (h<hmin)
        hmin=h;
    end
%if the error is above, repeat this step with new h
elseif ((error/abs(w))>tol)
    h=0.8*(((tol*abs(w))/error)^(1/3))*h;
    if (h>hmax)
        hmax=h;
    elseif (h<hmin)
        hmin=h;
    end
    s1=fhandle(told,wold);
    s2=fhandle(told+h,wold+h*s1);
    s3=fhandle(told+0.5*h, wold+0.5*h*((s1+s2)/2));
    w=RK2(wold,h,s1,s2);
    z=RK3(wold,h,s1,s2,s3);
    error=abs(h*((s1-2*s3+s2)/3));
end
% if the error is STILL above tol, keep halving until
% its below.
while ((error/abs(w))>tol)
    h=0.5*h;
    if (h>hmax)
        hmax=h;
    elseif (h<hmin)
        hmin=h;
    end
    s1=fhandle(told,wold);
    s2=fhandle(told+h,wold+h*s1);
    s3=fhandle(told+0.5*h, wold+0.5*h*((s1+s2)/2));
    w=RK2(wold,h,s1,s2);
    z=RK3(wold,h,s1,s2,s3);
    error=abs(h*((s1-2*s3+s2)/3));
end
t=t+h;
tabel(1,i)=t;
tabel(2,i)=w;
tabel(3,i)=z;
i=i+1;
end 
tabel(:,i:end)=[];
%keyboard
%w
hmax
hmin
%t
i
plot(tabel(1,:),tabel(2,:))
hold on
end

%we put the functions for each step here, since we
%migth need to reiterate a step after altering stepsize
% h, so we can now call them more than once for each for 
%iteration. 
function [w] = RK2(w,h,s1,s2)
w=w+h*((s1+s2)/2);
end
function [z] = RK3(w,h,s1,s2,s3)
z= w+h*((s1+4*(s3)+s2)/6);
end
