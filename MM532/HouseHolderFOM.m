function[x] = HouseHolderFOM(A,b,x0,m,iterations)
%Søren Elmely Pettersson & Lasse Melbye
%HouseHolder[n n_tmp] = size(A);
%m must be less than or equal length of v
%THIS DOES NOT WORK :(
%
%We initially tried "combining" the loops so to say, of the householder
%and the fom loops into one. We had trouble with this since the h of
%householder is of index hj-1. We tried running one step beforehand, but
%this did not work either. 
%
%We tried the following instead, running and creating all the H's and W's
%and then running FOM afterwards, but the results are not correct. 
n=length(b);
H = zeros(n,m);
W = zeros(n,m);
zv=x0; %z_1, we only need previous z, we dont need older z's
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
%FOM
    r0 = b-A*x0;
    beta = norm(r0);
    p = zeros(size(A,1), iterations);
    z = zeros(iterations);
    x = zeros(size(b));
    z = zeros(iterations,1);
    u = zeros(iterations);
    %sign(r0/b)*beta
    z(1) = beta;
    %t = r0/beta;
    %V = zeros(size(A,1), m);
    %V(:,1) = t; 
    l = zeros(size(A,1),1);
    for j = 1:iterations
        % Arnoldi start
        % Arnoldi end
        u(1,j) = H(1,j);
        if (j > 1)
            l(j-1) = H(j,j-1)/u(j-1, j-1);
            z(j) = -l(j-1)*z(j-1);
        end
        for i = 2:j
            u(i,j) = H(j,i)-l(i-1)*u(i-1,j);
        end
        p(:,j) = V(:,j)/u(j,j);
        for i = 1:j-1
            p(:,j) = p(:,j)-u(i,j)/u(j,j)*p(:,i);
        end
        if (j == 1)
           x = x0+z(j)*p(:,j);
        else
           x = x_prev+z(j)*p(:,j);
        end
        x_prev = x;
        if (j < iterations)
            H(j+1,j) = norm(W(:,j));
            if (H(j+1,j) == 0)
                'H(j+1,j) == 0'
                return;
            end
            V(:, j+1) = W(:,j)/H(j+1,j);
            if (H(j+1,j) < 1e-10)
                'tol reached'
                j
                return
            end
        end
    end
end





