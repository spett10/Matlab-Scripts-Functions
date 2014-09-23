% Arnoldi method By Lasse Melbye and Søren Petterson

% NOTE: 
% A must be nonsingular, sparse and positive definite (Av, v) > 0 for all v
% in addition we have the optimality condition A should be symetric (A^T =
% A)
% Can be obtained by Ax = b <=> A^TAx =A^Tb

% Test can be done with 
% A = comp_A(5,5);
% b = -ones(size(A,1),1)
% [fom(A, b, zeros(25,1), 40), linsolve(A'*A,A'*b)]

function [x] = fom(A, b, x0, m)
    r0 = b-A*x0;
    beta = norm(r0);
    p = zeros(size(A,1), m);
    z = zeros(m);
    x = zeros(size(b));
    z = zeros(m,1);
    u = zeros(m);
    z(1) = beta;
    t = r0/beta;
    V = zeros(size(A,1), m);
    V(:,1) = t; 
    l = zeros(size(A,1),1);
    for j = 1:m
        % Arnoldi start
        w = A*V(:,j);
        for i = 1:j
            h(i,j) = (w'*V(:,i));
            w = w-h(i,j)*V(:,i);
        end
        h(j+1,j)= norm(w);
        if h(j+1,j) == 0;
           'h(j+1,j)'
           break; % GOTO end for loop
        end
        vp = w/h(j+1,j);
        V = [V vp];
        % Arnoldi end
        u(1,j) = h(1,j);
        if (j > 1)
            l(j-1) = h(j,j-1)/u(j-1, j-1);
            z(j) = -l(j-1)*z(j-1);
        end
        for i = 2:j
            u(i,j) = h(j,i)-l(i-1)*u(i-1,j);
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
        if (j < m)
            h(j+1,j) = norm(w);
            if (h(j+1,j) == 0)
                'h(j+1,j) == 0'
                return;
            end
            V(:, j+1) = w/h(j+1,j);
            if (h(j+1,j) < 1e-10)
                'tol reached'
                j
                return
            end
        end
    end
end

   