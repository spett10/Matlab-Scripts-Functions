% Household Arnoldi

function x = arnoldihouse(A,b,m)


% Begin House stuff:
% X = A
% Pw * x = (1-2*w*W^T)*x = x-2*w*(w^T*x) = x-2(w,x)*w
% Pk = I-2*wk*wk^T
% wk = z/norm(z)
% z_i = 0 if i < k
% z_i = beta + x_ii if i=k
% z_i = x_ik if i > k
% beta = sign(x_kk) * sqrt(sum from i=k to n over x_ik^2)
% End House Stuff

% CRAP SHIT FUCK
n = length(A);
z = b;
zmatrix = zeros(m,m);
zmatrix(:,1) = z;
w = zeros(n,n);
P = eye(n,n);
v = zeros(m,m);
v(:,1) = b;
%rk = zeros(n,n);
%if v == zeros(n,1), error('Vector equal to 0'), end
for k = 1:m %m+1?
	% Start householder Orthogonalization
	% make z
	for i = 1:n
		if i < k
			z(i) = 0;
		end
		if i == k
			beta = sign(v(k,k)) * sqrt(summation(v,i,k,n));
			z(i) = beta + v(i,i);
		end
		if i > k
			z(i) = v(i,k);
		end
		zmatrix(:,k) = z;
	end
	%if k > 1
	%	for l = j:-1:1
	%		rk = rk + eye(n,n)-2*w(:,l)*w(:,l)';
	%	end
		%rk = rk * v(:,k);
	
	%rk = (eye(n,n)-2*w(:,1)*w(:,1)')*rk;
	w(:,k) = z/norm(z);
	P = eye(n,n) - 2*w(:,k)*w(:,k)';
	R = (P*zmatrix)';
	v(:,k+1) = summation1(w,k,n);
	% End householder orthogonalization
end
x = v;
end
%R
%rk
function sum = summation1(w,j,n)
sum = zeros(n,n);
for l = 1:j
	sum = sum + eye(n,n)-2*w(:,l)*w(:,l)';
end
cake = zeros(n,1);
cake(j) = 1;
sum = sum * cake;
end

% summation of equation (1.26)
function sum = summation(v,i,k,n)
sum = 0;
for l = k:n
	sum = sum + v(i,l)^2;
end
end

