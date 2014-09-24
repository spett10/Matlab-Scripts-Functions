function A=makeA(n1,n2)
%generates matrix a which is the discretized laplacian operator
%using a finite difference scheme (of order 2)
%
%n1 and n2 are the number of points in discretization in the domain,
%in x and y direction respectively (excluding boundary! due to boundary
%conditions).
%
%For this project arguments where the following:
%A=makeA(99,49);
%
h1=2/(n1+1);%distance between points in x direction
h2=1/(n2+1);%distance between points in y direction
H = -2/h1^2-2/h2^2;

% Greate a sub matrix b which repeats in diagonal of A
B = eye(n1)*H; %First diagonal
B = B + diag(ones(n1-1,1)/h1^2,1)+...
    diag(ones(n1-1,1)/h1^2,-1); %Then off-diagonal
%Greate matrix A
A = kron(eye(n2),B)+... 
    kron(diag(ones(n2-1,1),1),eye(n1)/h2^2)+...
    kron(diag(ones(n2-1,1),-1),eye(n1)/h2^2);

%kron multiplies each entry of first matrix with the second matrix
%i.e. 
%first line: makes a block diagonal matrix of B
%second line: upper diagonal block matrix of unitmatrices
%third line: lower diagonal block matrix of unitmatrices

%To visualize the matrix use imagesc(abs(A)); 
%colormap(flipud(gray));

end