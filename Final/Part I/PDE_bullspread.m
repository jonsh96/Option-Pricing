function [V,S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J)
    % INPUTS: 
    %   - K1:    Strike price of the long call option
    %   - K2:    Strike price of the short call option
    %   - T:     Time to maturity (in years)
    %   - r:     Risk free interest rates (in decimals)
    %   - sigma: Volatility (in decimals)
    %   - Smin:  Lowest value of the stock price
    %   - Smax:  Highest value of the stock price
    %   - N:     Number of time steps
    %   - J:     Number of grid oints
    %   
    % OUTPUTS: 
    %   - V:    Price of the option
    %   - S:    Grid of underlying prices
    % 
    % AUTHOR: 
    %   - Dwight Barkley 
    % 
    % EDITED BY: 
    %   - Jón Sveinbjörn Halldórsson 22/11/2019
    %     - Changed functionality from pricing a call option to pricing a
    %       bullspread
    %
    % ABOUT: 
    %   - PDE solver for pricing a bul--call spread by using transformations 
    %     and solving the heat equation with Crank-Nicolson
    
    % See derivation of variables in report
    k = 2*r/sigma^2;
    alpha = -0.5*(k-1);
    beta  = -0.25*(k+1)^2;

    % Transformation S = exp(x)
    xmin = log(Smin);
    xmax = log(Smax);
    % Transformation t = T - 0.5*sigma^2
    tau_max = T*sigma^2*0.5;

    % Initial condition for heat equation variable u
    u0 = @(x) (max(exp(x)-K1,0)-max(exp(x)-K2,0))./exp(alpha*x);

    % Boundary conditions on u. 
    gmin = @(tau) 0;
    gmax = @(tau) (K2-K1)*exp(-alpha*xmax-(beta+k)*tau);

    % solve heat equation
    [u,x,tau] = heat_CN(u0, gmin, gmax, tau_max, xmin, xmax, N, J);

    % Transform back from (x,u) to (S,V)
    S = exp(x);
    V = u(:,end)'.*exp(alpha*x+beta*tau_max);
end
