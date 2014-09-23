function [x] = GMRES(A,b,x0,m)
%for solving the system of linear equations Ax = b
%using the restarted GMRES(m) algoritm, based on HouseHolder QR
%decomposition
r0=b-A*x0;
z=r0;
n=length(A);
beta=norm(r0);
v=r0/beta;
H=zeros(n,m);
W=zeros(n,m);%only thing we need to save is W vectors (in principle)

%one round of householder so we get the first H, W and V. 
beta=sign(z(1))*sqrt(sum(z(1:n).^2)); %beta, 1.26
W(1,1)=z(1)+beta; %1.25 beta + x_ii
W(2:n,1)=z(2:n); %1.25 z_i = x_ik hvis i>k, og 2:n >1 i dette tilfaelde!
W(:,1)=W(:,1)/norm(W(:,1)); %1.24, norm til 1 
h0=(r0-2*(W(:,1)'*r0)*W(:,1));%h_1-1 := P_1*z
v=eye(n,1);%v er e_j, dvs e_1, pga linje nedenunder (dirty dirty hack)
v=v-2*(W(:,1)'*v)*W(:,1); %første V:=P1P2..Pjej, dvs v:=p1*ej
z=A*v;
z=z-2*(W(:,1)'*z)*(W(:,1)); %da 1<=m, z:=P1Av, vores nye z

for j=2:m+1
   %compute householder unit vector w_j
   W(1:j-1,j)=zeros(j-1,1); %første j-1 komponenter er 0! (1.25 linje 1)
   beta=sign(z(j))*sqrt(sum(z(j:n).^2));%get beta!
   W(j,j)=beta+z(j);%now use beta! (1.25 linje 2)
   W(j+1:n,j)=z(j+1:n);%remaining elements (1.25 linje 3)
   W(:,j)=W(:,j)/norm(W(:,j)); %normalize (1.24)
   %now householder is done!
   hi=j-1;%index til at lave H
   %if (j==1)
      %beta0=eye(n,1)'*h0;%not the same beta 
   %else
       %H(:,hi) = (eye(n,n)-2*W(:,j)*W(:,j)')*z;%P_j skal ikke formes eksplicit
        H(1:j,hi)=(z(1:j)-2*(W(:,j)'*z)*W(1:j,j));
   %end
   %lav v
   v = zeros(n,1);%v=P1P2..Pjej
			v(j)=1;%e_j
			for k=j:-1:1
				v = v - 2*(W(:,k)'*v)*W(:,k);%vi gør det den anden vej 
            end
   if (j<=m)%linje 8
      z = A*v;%z:=P_jP_j-1...P_1Av
			for t=1:j
				z = z - 2*(W(:,t)'*z)*W(:,t);%vi gør det den anden vej
            end
   end
   
end
%transform h matrix to upper hessenberg
%consider the upper part of H_m
Hm=zeros(m+1,m);
for j=1:m
   Hm(1:j+1,j)=H(1:j+1,j);
end
%construct g vector
g=zeros(m+1,1);
%g(1)=1;
%g=g'*h0;%brug evt h0(1) som beta
g(1)=h0(1);
%apply rotation matrices to g and hm
for j=1:m
   Oi=eye(m+1,m+1); 
   si=(Hm(j+1,j))/(sqrt(Hm(j,j)^2+Hm(j+1,j)^2));
   ci=(Hm(j,j))/(sqrt(Hm(j,j)^2+Hm(j+1,j)^2));
   Oi(j,j)=ci;
   Oi(j+1,j+1)=ci;
   Oi(j,j+1)=si;
   Oi(j+1,j)=-si;
   Hm=Oi*Hm;
   g=Oi*g;
end
%residual is last element of g!
%the solution to ||beta e_1 - Hm y||_2
%is obtained by solving the triangular system resulting from deleting
%the last row of the matrix Rm and righthandside gm (6.36)
Rm=Hm(1:m,1:m);
gm=g(1:m);
res=g(m+1);
ym=zeros(m,1);
%calculate the vector ym by backwards substitution of the upper triangualr
%problem
for i=m:-1:1
    sumin=0;
    for j=i+1:m
        sumin=sumin+Rm(i,j)*ym(j);
    end
    ym(i)=(1/Rm(i,i))*(gm(i)-sumin);
end
%ym
%udregn dine z, tjek residual, vha z lav x, done!
z=zeros(n,1);
for j=m:-1:1
    %ej=zeros(n,1);
    %ej(j)=1;
    %z=(eye(n,n)-2*W(:,j)*W(:,j)')*(ym(j)*ej+z);
    z(j)=z(j)+ym(j);
    z=(z-2*((W(:,j)'*z)*W(:,j)));%to save time! 
end
tempx=x0+z;
%res
if (res>10^-5)
   %disp('Restarting!');
   x=tempx;
   GMRES(A,b,x,m)
else
   x=tempx; 
end

%restarting:

end