function x=FOM_HH(A,b,m)

% credit goes to Ari, seventh lord of Moria

r0 = b;
beta = norm(r0);
[n row] = size(A);
x = zeros(n,1);
H = zeros(m+1,m);
U = zeros(m,m);
res_vec = [];
P = [];

% First Householder iteration. To get w1 and zv
beta = sign(r0(1))*norm(r0);
W = zeros(n,m+1);
W(1,1) = r0(1)+beta;
W(2:n,1) = r0(2:n);
W(:,1) = W(:,1)/norm(W(:,1));
z = (r0(1)-2*(W(:,1)'*r0)*W(1,1));
L = zeros(n-1,1);
v = zeros(n,1);
v(1) = 1;
v = v-2*(W(:,1)'*v)*W(:,1);
zv = A*v;
zv = zv-2*(W(:,1)'*zv)*W(:,1);

for k=2:m+1
    W(1:k-1,k) = zeros(k-1,1);
    beta = sign(zv(k))*sqrt(sum(zv(k:n).^2));
    W(k,k) = beta + zv(k);						% set next component to beta + zv
	W(k+1:n,k) = zv(k+1:n);
	W(:,k) = W(:,k)/norm(W(:,k));				% normalize
    hi = k-1;
    H(1:k,hi) = zv(1:k)-2*(W(:,k)'*zv)*W(1:k,k);
    U(1,hi) = H(1,hi);
    if (hi > 1)
        L(hi-1) = H(hi,hi-1)/U(hi-1,hi-1);
        z = -L(hi-1)*z;
    end
    for l = 2:hi
        U(l,hi) = H(hi,l)-L(l-1)*U(l-1,hi);
    end
    Ptmp = v/U(hi,hi);
    for l = 1:hi-1
        Ptmp = Ptmp - U(l,hi)/U(hi,hi)*P(:,l);
    end
    P = [P, Ptmp];
    x = x + z*Ptmp;
    if (k < m+1)
        if (H(hi+1,hi) == 0)
            break;
        end
        res_vec = [res_vec abs(H(hi+1,hi))*abs(z/U(hi,hi))]; % Mangler der mere???
        norm(A*x-b);
        res_vec(hi);
        if (res_vec(hi) < 1e-10)
            break;
        end
        v = zeros(n,1);
        v(k) = 1;
        for j=k:-1:1
            v = v - 2*(W(:,j)'*v)*W(:,j);
        end
        zv = A*v;
        for j=1:k
            zv = zv - 2*(W(:,j)'*zv)*W(:,j);
        end
    end
end
