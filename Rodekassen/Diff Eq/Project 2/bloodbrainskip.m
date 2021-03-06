
function [] = bloodbrainskip(x0,y0,t0,n,h,A,tp)
%project 4 page 211-213 brannan & boyce
% x0, y0, t0 er startv�rdier
% n er antal iterationer
% h er skridtl�ngden pr iteration
% d er dosism�ngden
% tp er intervallet hvormed der gives ny dosis
t=t0;
x=x0;
y=y0;

d=A;

skipoutput=zeros(3,n+1);
skipoutput(:,1)=[t0;x0;y0];

i=2;

f=@(t,c1,c2) -((0.16+0.29)*c1)+(((0.31*0.25)/(6))*c2)+((1/6)*d);
f0=@(t,c1,c2) -((0.16+0.29)*c1)+(((0.31*0.25)/(6))*c2);
fdouble=@(t,c1,c2) -((0.16+0.29)*c1)+(((0.31*0.25)/(6))*c2)+((1/6)*(2*d));
g=@(t,c1,c2) (((6*0.29)/(0.25))*c1)-(0.31*c2);

%hvis t er mindre end 1 opf�rer koncentrationen sig som f
%hvis t ligger over dette opf�rer den sig som f0
%hvis der spr�jtes nyt ind igen, til tiden tp, opf�rer den sig igen
%som f. 

%n�r vi n�r til en ny dosis ligger t mod tp i intervallet 0 til 1, (da tb
%er 1!) og heri v�lger vi f som vores funktion. 

%ellers v�lger vi f0. 

for j=1:h:n
   if (t<=1|(mod(t,tp)>=0 & mod(t,tp)<=1))
       if (t>=48 & t<=49)
           k1=f0(t,x,y);
       elseif (t>=72 & t<=73)
           k1=fdouble(t,x,y);
       else
           k1=f(t,x,y);
       end
       
   else
       k1=f0(t,x,y);
   end
   k2=g(t,x,y);
   x=x+h*k1;
   y=y+h*k2;
   t=t+h;
   skipoutput(3,i)=y;
   skipoutput(2,i)=x;
   skipoutput(1,i)=t;
   i=i+1;
end

plot(skipoutput(1,:),skipoutput(3,:))
end