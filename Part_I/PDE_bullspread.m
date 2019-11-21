function [V,S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J)

% EURO_CALL_PDE - Pricing of Euro call option via PDE (heat equation). 
%
% K - strike price
% T - Time to maturity
% r - interest rate
% sigma - volatility
% Smin, Smax - range of S
% N, J - number of grid points in time and S respectively
% V - price of the option
% S - grid of underlying prices

k = 2*r/sigma^2;
alpha = -0.5*(k-1);
beta  = -0.25*(k+1)^2;

xmin = log(Smin);
xmax = log(Smax);
tau_max = T*sigma^2*0.5;

% Initial condition for heat equation variable u
u0 = @(x) (max(exp(x)-K1,0)-max(exp(x)-K2,0))./exp(alpha*x);

% Boundary conditions on u. 
gmin = @(tau) 0;
gmax = @(tau) (K2-K1)./exp(alpha*xmax);

% solve heat equation
[u,x,tau] = heat_CN(u0, gmin, gmax, tau_max, xmin, xmax, N, J);

% Transform back from (x,u) to (S,V)
S = exp(x);
V = u(:,end)'.*exp(alpha*x+beta*tau_max);