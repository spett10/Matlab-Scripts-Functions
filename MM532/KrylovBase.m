function[V,H] = KrylovBase(A,v,m)
%Credit goes to Ari 
%HouseHolder[n n_tmp] = size(A);
%m must be less than or equal length of v
n=length(v);
H = zeros(n,m);
W = zeros(n,m);
zv=v; %z_1, we only need previous z, we dont need older z's
V=[];
for k=1:m+1
	W(1:k-1,k)=zeros(k-1,1); %first components zero
	beta=sign(zv(k))*sqrt(sum(zv(k:n).^2));
	W(k,k)=beta+zv(k);
	W(k+1:n,k) = zv(k+1:n);
	W(:,k)=W(:,k)/norm(W(:,k)); %normalize to 1
	if (k>1)
	%   zv(k+1:n) = zeros(n-k,1); %dont mind, books says this, but you dont need it
        H(:,k-1) = (zv-2*(W(:,k)'*zv)*W(:,k));
    end
		if (k<=m)
			vn = zeros(n,1);
			vn(k)=1;
			
			for j=k:-1:1
				vn = vn - 2*(W(:,j)'*vn)*W(:,j);
			end
			V = [V vn];
			zv = A*vn;
			for j=1:k
				zv = zv - 2*(W(:,j)'*zv)*W(:,j);
			end
				%Z = zv; %not needed, dont copy this 
		end
end
%transform h matrix to uppser hessenberg
end
%to test, V'*V = identity