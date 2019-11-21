function [U, x, t] = heat_CN(u0, gmin, gmax, t_f, xmin, xmax, N, J)
% About: Crank-Nicolson solver ...
% Author: Dwight ...
% Edited 20/11/2019 by Jón Sveinbjörn Halldórsson
% 
% Solve heat equation d_t u = d_xx u by Backward Euler scheme
% with general Dirichlet boundary conditions.
%
% u0 - Initial condition (function handle)
% gmin, gmax - The boundary conditions (function handles)
% t_f - Final time
% xmin, xmax - the range of the 'x' variable
% N - the number of time steps
% J - the number of intervals in 'x' direction
%
% U - the solution
% x, t - vectors of grid points

h  = (xmax-xmin)/J;
dt = 0.5*t_f/N;
nu = dt/h^2;

t = [0:dt:t_f];
x = [xmin:h:xmax];

% Nplot is the frequency of plotting
Nplot = 10;

% Set up tridiagonal matrix I-dtL. We do this by constructing the three
% diagonals of dtL. From these generate the diagonals of I-dtL. 
dtL_sup =  nu * [0;      ones(J-1,1)];
dtL_diag = nu * [0; -2 * ones(J-1,1); 0];
dtL_sub =  nu * [        ones(J-1,1); 0];

I_dtL_sup = - dtL_sup  ;
I_dtL_diag = ones(J+1,1) - dtL_diag;
I_dtL_sub = - dtL_sub;

% Generate a (J+1) x (J+1) matrix for the implicit part of the time step.
% (This is not efficient and will be improved next week.)
I_dtL = diag(I_dtL_diag) + diag(I_dtL_sup,1) + diag(I_dtL_sub,-1);

% If N= 1 and J is small (eg 4) you can output the matrix.
% I_m_dtL

% Allocate solution matrix will all zeros. Allocate vector RHS that will 
% be the right-hand-side of a linear system of equations.
U = zeros(J+1, N+1);
RHS = zeros(J+1, 1);

% set initial condition
U(:,1) = u0(x);

% Main time stepping loop
for n=1:N
    
    % "Explicit" part of time step. 
    RHS(  1) = gmin(t(n+1));
    RHS(2:J) = U(2:J,n) + nu*(U(1:J-1,n)-2*U(2:J,n)+U(3:J+1,n));
    RHS(J+1) = gmax(t(n+1));
    
    % "Implicit" part of the time step:
    % Solve linear equations to obtain U^n+1 using Matlab \ operation. 
    % (This is not efficient and will be improved next week.)
    U(:,n+1) = I_dtL \ RHS;
    %U(:,n+1) = tridiag(I_dtL_sub, I_dtL_diag, I_dtL_sup, RHS);
    % plot the solution
%     if mod(n,Nplot)==0
%         plot(x,U(:,n+1))
%         %axis([0, 1, -10, 10]);
%         drawnow
%     end
end

end
