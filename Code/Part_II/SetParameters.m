%% PART 2
% Initialising the variables
K = 50;         % Strike price
T = 1;          % Time to maturity
Nsteps = 260;   % Number of trading/working days in a year
dt = T/Nsteps;  % Euler time step of one day

Smin = 1;       % Minimum stock price
Smax = 100;     % Maximum stock price
M = 1000;       % Number of Monte Carlo simulations for each method

% Defining the interest rate model
r = [0.05 0.5];
rate = @(t) r(1)*exp(r(2)*t);

% Defining the local volatility model
sigma = [0.30 0.12 0.60];
volatility = @(S,t) sigma(1)*(1+sigma(2)*cos(2*pi*t))*(1+sigma(3)*exp(-S/100));

% Defining the put option payoff
put_payoff = @(S) (max(K - S(:,end), 0));
%exp(-integral(rate,0,T))*
% Defining the barrier option payoff as a function of S and Sb
barrier_payoff = @(S,Sb) max(K - S(:,end),0).*(min(S,[],2) > Sb);
% exp(-integral(rate,0,T))*
barrier = 30;

% Gathering the Black-Scholes prices for comparison
%   - Note that they won't be perfectly accurate since they assume constant interest
%     rates and volatility which this stochastic process does not follow
call = zeros(1,100);
put = zeros(1,100);

% Have to do this since there is no (simple) way to make a function handle
% of blsprice return the second output (put price)
for i = Smin:Smax
    [call(i), put(i)] = blsprice(i,K,r(1),1,sigma(1));
end
option_price = put;
