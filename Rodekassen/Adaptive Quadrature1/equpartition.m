function [a b] = equpartition( s )
%EQUPARTITION We utilize bisection and adaptive Quadrature to obtain
%Equipartion between 0 and 1 for s, t and f 
%this is for the specific exercise p 279 sauer
%to generalize, just input function handles and do the same 
f = @(t) ((0.3+7.8*t-14.1*t^2)^2+(0.3+1.8*t-8.1*t^2)^2)^(0.5);
t = @(t) adapquad(f,0,t,0.001)-(s)*(adapquad(f,0,1,0.001));
[ a b ]=Bisection(t,0,1,0.001);

end

