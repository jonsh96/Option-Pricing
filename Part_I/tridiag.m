function x = tridiag(dm, d0, dp, b)

% Function for solving the system of linear equations Ax=b,
% where A is a tridiagonal matrix.
%
% 
% d0 - vector containing the diagonal elements of A.
% dp - vector containing the superdiagonal elements of A.
%
% b - a right-hand-side vector (not a matrix in this function)
% x - the solution vector

% Some sanity checks
% ------------------
N = length(d0);
if length(dm) ~= N-1 || length(dp) ~= N-1 || size(b,1) ~= N
    error('Dimensions are not consistent')
end
if size(b,2) ~= 1
    error('b must be a vector in tridiag')
end


% Forward elimination
% -------------------

for k = 1:N-1
    c = dm(k)/d0(k);
    d0(k+1) = d0(k+1) - c*dp(k);
    b (k+1) = b (k+1) - c*b (k);
end

% Backward substitution
% ---------------------

x(N,1) = b(N)/d0(N);  % this both creates x and sets the Nth value.
for k=N-1:-1:1
    x(k) = (b(k) - dp(k)*x(k+1)) / d0(k);
end

end