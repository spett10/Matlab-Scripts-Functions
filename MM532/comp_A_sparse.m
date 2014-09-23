function A=comp_A_sparse(nx,ny)
%COMP_A_sparse(NX,NY) generates sparse matrix A which 
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

% Create a sub matrix b which repeats in diagonal of A
B = sparse(1:nx,1:nx,1)*H; %First diagonal
B = B + sparse(1:nx-1,2:nx,1,nx,nx)/hx^2+sparse(2:nx,1:nx-1,1,nx,nx)/hx^2; %Then off-diagonal
%Create matrix A
A = kron(sparse(1:ny,1:ny,1,ny,ny),B)+... 
    kron(sparse(1:ny-1,2:ny,1,ny,ny),sparse(1:nx,1:nx,1,nx,nx)/hy^2)+...
    kron(sparse(2:ny,1:ny-1,1,ny,ny),sparse(1:nx,1:nx,1,nx,nx)/hy^2);