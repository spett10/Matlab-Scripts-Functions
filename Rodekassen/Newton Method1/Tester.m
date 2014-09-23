function [f ] = Tester(x1,x2,x3)
%We quickly test our values to see if our values make our functions 
%go to zero
   f1=2.*x1.^2-4.*x1+x2.^2+3.*x3.^2+6.*x3+2;
   f2=x1.^2+x2.^2-2.*x2+2.*x3.^2-5;
   f3=3.*x1.^2-12.*x1+x2.^2+3.*x3.^2+8;
   f=[f1 f2 f3];

end

