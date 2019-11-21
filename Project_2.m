%% PART 2
% Initialising the variables
K = 50;     % Strike price
T = 1;      % Maturity
n = 260;    % Number of trading/working days in a year
dt = T/n;   % Size of each time increment (in years)

% Defining the interest rate model
r = [0.05 0.5];
rate = @(t) r(1)*exp(r(2)*t);

% Defining the local volatility model
sigma = [0.30 0.12 0.60];
volatility = @(S,t) sigma(1)*(1+sigma(2)*cos(2*pi*t))*(1+sigma(3)*exp(-S/100));

N = 1;
S0 = 50;
% Preallocating memory
S = zeros(n,N);
S(:,1) = S0;
dS = ones(n,N);

for i = 1:N
    dW = sqrt(dt)*randn(n);
    for j = 2:n
        % Defining the underlying process of the stock price
        t = (j-1)*dt;
        dS(i,j-1) = rate(t)*S(i,j-1)*dt + volatility(S(i,j-1),t)*S(i,j-1)*dW(i,j-1);
        S(i,j) = S(i,j-1) + dS(i,j-1);
    end
    plot(S(i,:))
    hold on
end
grid on
plot([0 n], [35 35],'k--')
xlim([0 n])