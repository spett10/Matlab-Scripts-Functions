function b=comp_B2(nx,ny)
% should be called with the same as make_A(nx,ny)
% ex: 59, 29
% ex: 5, 2
% ex: 11, 5
% ex: 
%this function caluculates the vector b which is equal to -\rho

%initialize vector b with size = to grid points.
n  = (nx*ny)
b = zeros(n,1);
tmpmatrix = zeros(nx,ny);
counter = 0;

% we distribute the points in natural ordering
% that is from 0-nx/ny in x direction first,
% then go to second row of ny and go through x direction again, ect.

for j=1:ny
	for k = 1:nx
		counter = counter + 1;
		if j == floor((ny+1)/3)
			if k >= floor((nx+1)/6) && k <= floor((nx+1)/6*5)
				% on AB
				b(counter) = 1;
				tmpmatrix(j,k) = -1;
			end
		end
		if j == floor((ny+1)/3*2)
			if k >= floor((nx+1)/6) && k <= floor((nx+1)/6*5)
				% on CD
				b(counter) = -1;
				tmpmatrix(j,k) = -1;
			end
		end  
	end
end
