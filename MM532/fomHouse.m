function [x] = fomHouse(A, b, x0, m)
    dim = size(A,1)-1;
    r0 = b-A*x0;
    n=length(b);
    beta = norm(r0);
    p = zeros(size(A,1), m);
    z = zeros(m);
    x = zeros(size(b));
    z = zeros(m,1);
    u = zeros(m);
    z(1) = beta;
    h = zeros(n,m);
    V = zeros(size(A,1), m);
    zv = b;
    l = zeros(size(A,1),1);
    j=1;
    % First householder iteration to obtain first h and v
    W(1,1)=zeros(1,1);
    beta=sign(zv(1))*sqrt(sum(zv(j:n).^2));
    W(1,1)=beta+zv(1);
    W(2:n,1) = zv(2:n);
	W(:,1)=W(:,1)/norm(W(:,1)); %normalize to 1
    W(1,2)=zeros(1,1);
    beta=sign(zv(2))*sqrt(sum(zv(2:n).^2));
    W(2,2)=beta+zv(2);
    W(3:n,2) = zv(3:n);
    W(:,2)=W(:,2)/norm(W(:,2));
    H(:,1) = (zv-2*(W(:,2)'*zv)*W(:,2));%først ved k=2 kan vi regne h_k-1 = h_1 ud
    %vi skal også regne det første v:
    vn = zeros(n,1);
	vn(2)=1;
    for j=2:-1:1
		vn = vn - 2*(W(:,j)'*vn)*W(:,j);
	end
	V = [V vn];%Vores første V er fra householder. 
	zv = A*vn;
	for j=1:2
		zv = zv - 2*(W(:,j)'*zv)*W(:,j);
    end
     %we need to combine the loops and thus adjust indices as well
        %Krylov start, one step for each iteration
        %tror index i W og H skal rykkes 1 "frem"
    for j = 2:1:m+1 
        W(1:j-1,j)=zeros(j-1,1); %first components zero
        beta=sign(zv(j))*sqrt(sum(zv(j:n).^2));
        W(j,j)=beta+zv(j);
        W(j+1:n,j) = zv(j+1:n);
        W(:,j)=W(:,j)/norm(W(:,j)); %normalize to 1
        if (j>1)
        %   zv(j+1:n) = zeros(n-j,1); %dont mind, books says this, but you dont need it
            H(:,j-1) = (zv-2*(W(:,j)'*zv)*W(:,j));%stadig forkerte index.. wtf
        else 
            
        end
		if (j<=m)
			vn = zeros(n,1);
			vn(j)=1;
			
			for i=j:-1:1
				vn = vn - 2*(W(:,i)'*vn)*W(:,i);
			end
			V = [V vn];
			zv = A*vn;
			for i=1:j
				zv = zv - 2*(W(:,i)'*zv)*W(:,i);
			end
				%Z = zv; %not needed, dont copy this 
        end
        %Krylov end
        u(1,j) = H(1,j)%hvad gør vi her? vores loop starter på 2!
        if (j > 2)
            l(j-1) = H(j,j-1)/u(j-1, j-1);
            z(j) = -l(j-1)*z(j-1);
        end
        for i = 2:j
            u(i,j) = H(j,i-1)-l(i-1)*u(i-1,j);
        end
        p(:,j) = V(:,j)/u(j,j);
        for i = 1:j-1
            p(:,j) = p(:,j)-u(i,j)/u(j,j)*p(:,i);
        end
        if (j == 2)
            z(j)%-inf
            p(:,j)%ren 0
           x = x0+z(j)*p(:,j)
        else
           x = x_prev+z(j)*p(:,j);
        end
        x_prev = x;
        if (j < m)
            H(j+1,j) = norm(W);
            if (H(j+1,j) == 0)
                'H(j+1,j) == 0'
                return;
            end
            V(:, j+1) = W(:,j)/h(j+1,j);
            if (H(j+1,j)*abs(z(j)/u(j,j))) < 1e-10
                H(j+1,j)
                'tol reached'
                j
                return
            end
        end
    end
end

   