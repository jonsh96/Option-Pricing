%% PART 2
% Initialising the variables
K = 50;     % Strike price
T = 1;      % Maturity
N = 260;    % Number of trading/working days in a year

Smin = 1;
Smax = 100;

payoff = @(S) max(K - S, 0);

% Defining the interest rate model
r = [0.05 0.5];
rate = @(t) r(1)*exp(r(2)*t);

% Defining the local volatility model
sigma = [0.30 0.12 0.60];
volatility = @(S,t) sigma(1)*(1+sigma(2)*cos(2*pi*t))*(1+sigma(3)*exp(-S/100));

