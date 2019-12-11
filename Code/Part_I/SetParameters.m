% Initialising the variables for Part I
format compact;

K1 = 90;            % Strike price 1 (lower)
K2 = 120;           % Strike price 2 (upper)
T = 6/12;           % Time to maturity
dt = T;             % Time increments for Monte Carlo
rate = 0.03;        % (Constant) Risk free interest rates
volatility = 0.25;  % (Constant) Volatility of stock
N = 260*T;          % Initial "guess" for the number of time steps (trading/working days in 6 months)
M = 1000;           % Number of Monte Carlo simulations
Smin = 1;           % Minimum initial stock price
Smax =  200;        % Maximum initial stock price

% Defining the payoff function for convenience
option_price = @(S) blsprice(S, K1, rate, T, volatility)-blsprice(S, K2, rate, T, volatility);
% BS_bullspread is now an anonymous function which uses the Black-Scholes function blsprice to compare the price.    

% Payoff is the discounted payoff at maturity as a function of the stock price at maturity, S
option_payoff = @(S) exp(-rate*T)*(max(S(:,end)-K1,0)-max(S(:,end)-K2,0));

% Bullspread delta defined
option_delta = @(S) blsdelta(S,K1,rate,T,volatility)-blsdelta(S,K2,rate,T,volatility);

% Finding the number of grid points, J, such that the error is < 0.05
J = MinimizeAbsError(K1, K2, T, rate, volatility, Smin, Smax, N, option_price);