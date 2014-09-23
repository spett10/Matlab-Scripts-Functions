function A=comp_A(nx,ny)
%COMP_A(NX,NY) generates matrix A which 
% is discretizes Laplace operator.
% I.e. it 
% Laplace equation 
% \nabla^2 u(x,y) = f
% u(x,y) = 0
%
% A \vec{x} = \vec{b}
%
% nx,ny the number of points in discretization (excluding
% boundaries) into direction x and y.

hx = 2/(nx+1); %distance between points in x direction
hy = 2/(ny+1); %distance between points in y direction
H = -2/hx^2-2/hy^2;

% Greate a sub matrix b which repeats in diagonal of A
B = eye(nx)*H; %First diagonal
B = B + diag(ones(nx-1,1)/hx^2,1)+...
    diag(ones(nx-1,1)/hx^2,-1); %Then off-diagonal
%Greate matrix A
A = kron(eye(ny),B)+... 
    kron(diag(ones(ny-1,1),1),eye(nx)/hy^2)+...
    kron(diag(ones(ny-1,1),-1),eye(nx)/hy^2);

%kron multiplies each entry of first matrix with the second matrix
%i.e. 
%first line: makes a block diagonal matrix of B
%second line: upper diagonal block matrix of unitmatrices
%third line: lower diagonal block matrix of unitmatrices


%To visualize the matrix use imagesc(abs(A)); 
%colormap(flipud(gray));
