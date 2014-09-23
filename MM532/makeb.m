function b=makeb(n1,n2)
%creates the b for our specific problem
%n1 is points in x direction for our grid
%n2 is points in y direction for our grid
%ONLY FOR OUR SPECIFIC DISCRETIZATION AND GRID! NOT FOR GENERAL PURPOSE
%meaning, called with:
%b=makeb(99,49);
n1n2=n1*n2;
tempb=zeros(n1n2,1);
tempb(1501:1568)=1;
tempb(3184:3251)=-1;
b=tempb;
end