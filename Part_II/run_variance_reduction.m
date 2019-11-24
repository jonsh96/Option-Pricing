set_parameters;
% Here I am working under the assumption that the time step is T

sample_size = @(v) (sqrt(v)*1.96/0.05)^2;

M = 1000;
price = zeros(3,M);
variance = zeros(3,M);
errors = zeros(3,M);
time = zeros(3,M);

S0 = linspace(1,100,N);
% Naive method
dW = sqrt(dt)*randn(1,M);
for i = 1:M
    start = cputime;
    S = ones(1,N)*S;
    for j = 1:N
        dS(j) = rate(j*dt)*S(j-1)*dt + volatility(S(j-1),j*dt)*S(j-1)*dW(i,j-1);
        S(j) = S(j-1) + dS(j);
    end
    price(i,1) = mean(payoff(ST));
    variance(i,1) = var(payoff(ST));
    time(i,1) = cputime-start;
end
sample_size_mc(1) = sample_size(mean(variance(:,1)));

% Antithetic variance reduction
for i = 1:M
    time(i,2) = cputime;
    dST = rate(0).*S0.*T + volatility(S0,0).*S0.*dW(i);
    Splus = S0 + dST;
    Sminus = S0 - dST;
    Z = (payoff(Splus)+payoff(Sminus))/2;
    price(i,2) = mean(Z);
    variance(i,2) = var(Z);
%    errors(i,2) = price_BS - price(i,2);
    time(i,2) = cputime-start;
end
sample_size_mc(2) = sample_size(mean(variance(:,2)));

% Control variates
g = @(S) S;
for i = 1:M
   	start = cputime;
    % TODO: FIX GM
    gm = S0.*exp(T*(rate(T)));
    gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
    dST = rate(0).*S0.*T + volatility(S0,0).*S0.*dW(i);
    ST = S0 + dST;
    covariance_matrix = cov(payoff(ST),ST);
    c = covariance_matrix(1,2)/var(ST);
    fcv = var(payoff(ST))*(1-(covariance_matrix(1,2))^2/(var(payoff(ST))*var(g(ST))));
    fc = payoff(ST)-c.*(g(ST)-gm);
    price(i,3) = mean(fc);
    variance(i,3) = var(fc);
    time(i,3) = cputime-start;
end

sample_size_mc(3) = sample_size(mean(variance(:,3)));

compare_monte_carlo(mean(price), mean(variance), mean(time), sample_size_mc)
