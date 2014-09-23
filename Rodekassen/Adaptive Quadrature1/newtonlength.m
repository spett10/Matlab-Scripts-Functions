function l = newtonlength(b,g,k)
%f er funktion, a og b er interval, g er startg�t, tolerance
% a er 0, b er t*(s), k er iterationer
f = @(t) ((0.3+7.8.*t-14.1*t.^2).^2+(0.3+1.8.*t-8.1.*t.^2).^2).^(0.5);
t=linspace(0,1,100);
res=0;
for i=1:k
    res = g - (adapquad(f,0,g,0.001)-b.*adapquad(f,0,1,0.001))./(f(g))
    g=res;
end
l=res;
end