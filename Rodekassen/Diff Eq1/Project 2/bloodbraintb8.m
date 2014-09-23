function [] = bloodbraintb8(x0,y0,t0,n,h,A,tp)
%project 4 page 211-213 brannan & boyce
% x0, y0, t0 er startv�rdier
% n er antal iterationer
% h er skridtl�ngden pr iteration
% d er dosism�ngden
% tp er intervallet hvormed der gives ny dosis

% we now have that T_b is 8 hours instead of 1. 

t=t0;
x=x0;
y=y0;

output=zeros(3,n+1);
output(:,1)=[t0;x0;y0];

i=2;

f=@(t,c1,c2) -((0.16+0.29)*c1)+(((0.31*0.25)/(6))*c2)+((1/6)*(A/8));
f0=@(t,c1,c2) -((0.16+0.29)*c1)+(((0.31*0.25)/(6))*c2);
g=@(t,c1,c2) (((6*0.29)/(0.25))*c1)-(0.31*c2);


%hvis t er mindre end 1 opf�rer koncentrationen sig som f
%hvis t ligger over dette opf�rer den sig som f0
%hvis der spr�jtes nyt ind igen, til tiden tp, opf�rer den sig igen
%som f. 

%det tager nu 8 timer for vores drug at komme fra mund til blod
%derfor skal vores valg af funktioner agerere herefter, samt r modificeres
%til A/8.

for j=1:h:n
   if (t<=8|(mod(t,tp)>=0 & mod(t,tp)<=8))
       k1=f(t,x,y);
   else
       k1=f0(t,x,y);
   end
   k2=g(t,x,y);
   x=x+h*k1;
   y=y+h*k2;
   t=t+h;
   output(3,i)=y;
   output(2,i)=x;
   output(1,i)=t;
   i=i+1;
end

plot(output(1,:),output(3,:))
end

