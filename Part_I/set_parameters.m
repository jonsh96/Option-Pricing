% Initialising the variable
format compact;

K1 = 90;        % Strike price 1
K2 = 120;       % Strike price 2
T = 6/12;       % Maturity
dt = T/250;     % Size of time increments
r = 0.03;       % (Constant) Risk free interest rates
sigma = 0.25;   % (Constant) Volatility of stock
N = 130;        % Initial "guess", number of trading/working days in 6 months

Smin = 1;
Smax = 500;

% Defining the payoff function for convenience
BS_bullspread = @(S) blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
payoff = @(S) max(S-K1,0)-max(S-K2,0);