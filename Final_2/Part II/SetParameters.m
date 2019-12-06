%% PART 2
% Initialising the variables
K = 50;     % Strike price
T = 1;      % Maturity
Nsteps = 260;    % Number of trading/working days in a year
dt = T/Nsteps;

Smin = 1;
Smax = 100;
M = 1000;

% Defining the interest rate model
r = [0.05 0.5];
rate = @(t) r(1)*exp(r(2)*t);

% Defining the put option payoff
put_payoff = @(S) exp(-integral(rate,0,T))*(max(K - S(:,end), 0));

% Defining the barrier option payoff as a function of S and Sb
barrier_payoff = @(S,Sb) exp(-rate(0)*T)*max(K-S(:,end),0).*(min(S,[],2) > Sb);
barrier = 30;

% Defining the local volatility model
sigma = [0.30 0.12 0.60];
volatility = @(S,t) sigma(1).*(1+sigma(2).*cos(2.*pi.*t)).*(1+sigma(3).*exp(-S./100));

% Gathering the Black-Scholes prices for comparison
%   - Note that they won't be accurate since they assume constant interest
%     rates and volatility which this stochastic process does not follow
call = zeros(1,100);
put = zeros(1,100);

for i = Smin:Smax
    [call(i), put(i)] = blsprice(i,K,rate(0),1,volatility(i,0));
end

option_price = put;
