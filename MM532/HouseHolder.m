function [v] = HouseHolder(A,x,m)
   %Lasse Melbye & Søren Pettersson
    %This does not work. The basic outline is there, 
    %but our understanding of the algoritm was poor, so we didnt make it
    %further than this. We have understanding the algoritms and steps in th
    %e book. This fails pretty fast due to index out of bounds error
    %we will submit this for now and work to get the code correct 
    n = size(A,1);
    z2 = zeros(m);
    z = zeros(m);
    z(:,1) = x;%ones(n,1)./norm(ones(n,1));
    w = zeros(m);
    v = zeros(m);
    h = zeros(m); 
    P = [];
    
    % Calculate x = [x, Ax, A^2x, ... A^m,x]
    Ap = A;
    for j = 1:m
        x = [x Ap];
        Ap = Ap*A;
    end
    
    for j = 1:(m+1)        
        for i = 1:j-1            
            beta = sign(x(j,j))*norm(x(j:n,j));
            if (i < j)
                z2(j,i) = 0;
            elseif (i == k)
                z2(j,i) = beta + x(i,i);
            else
                z2(j,i) = x(i,j);
            end
            w(j,i) = z(j,i)./norm(z(j,i));
        end
        P = [P eye(m) - 2*w(j)*w(j)'];
        if (j > 1)
            h(j-1) = P(j)*z(j);
        end
        PJ = eye(m);
        for i = 1:j
            PJ = PJ*P(i);
        end
        v(:,j) = PJ(j,:);
        if (j <= m)
             PJ = eye(m);
            for i = j:-1:1
                PJ = PJ*P(i);
            end
            z(:,j+1) = PJ*A*v(:,j);
        end
    end
    
end