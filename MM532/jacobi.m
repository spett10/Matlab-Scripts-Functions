% The Jacobi method
% By Christian Damsgaard Jørgensen, Rune Clausen, Ida Uhrenfeldt Skov

function X = jacobi(A, B, guess, tol, maximum)
p = length(B);
for k = 1:maximum
	for i = 1:N
		X(i) = (B(i) - A(i, [1:i-1, i+1:N]) * guess([1:i-1, i+1:N])) / A(i, i);
	end
	guess = X';
	if (abs(norm(X' - guess)) < tol) | (abs(norm(X' - guess)) / (norm(X) + eps) < tol)
		% OK, it converges now - let's stop!
		break
	end
end
X=X';