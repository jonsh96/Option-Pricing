% Initialising the variables for Part I
format compact;

K1 = 90;        % Strike price 1
K2 = 120;       % Strike price 2
T = 6/12;       % Maturity
dt = T/250;     % Size of time increments
r = 0.03;       % (Constant) Risk free interest rates
sigma = 0.25;   % (Constant) Volatility of stock
N = 130;        % Initial "guess", number of trading/working days in 6 months
Smin = 1;       % Minimum initial price
Smax =  200;     % Maximum initial price

% Defining the payoff function for convenience
BS_bullspread = @(S) blsprice(S, K1, r, T, sigma) - blsprice(S, K2, r, T, sigma);  
% BS_bullspread is now an anonymous function which uses the Black-Scholes
% function blsprice to compare the price.

payoff = @(S) exp(-r*T)*(max(S-K1,0)-max(S-K2,0));
% Payoff is the discounted payoff at maturity as a function of the stock
% price at maturity, S
