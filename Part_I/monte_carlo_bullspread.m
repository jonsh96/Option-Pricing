set_parameters;

S0 = linspace(1,200,N);
sample_size = @(v) (sqrt(v)*1.96/0.05)^2;
price_BS = mean(bullspread(S0));
M = 1000;
time = zeros(M,4);
price = zeros(M,4);
variance = zeros(M,4);
errors = zeros(M,4);
sample_size_mc = zeros(1,4);

% Naive method
for i = 1:1000
    start = cputime;
    X = rand(1,N);
    ST = S0.*exp((r-0.5*sigma^2)*T+sigma*sqrt(T).*X);
    price(i,1) = mean(payoff(ST));
    variance(i,1) = var(payoff(ST));
    errors(i,1) = price_BS - price(i,1);
    time(i,1) = cputime-start;
end
sample_size_mc(1) = sample_size(mean(variance(:,1)));

% Antithetic variance reduction
for i = 1:M
    time(i,2) = cputime;
    X = randn(1,N);
    Splus = S0.*exp((r-0.5*sigma^2)*T+sigma*sqrt(T).*X);
    Sminus = S0.*exp((r-0.5*sigma^2)*T-sigma*sqrt(T).*X);
    Z = (payoff(Splus)+payoff(Sminus))/2;
    price(i,2) = mean(Z);
    variance(i,2) = var(Z);
    errors(i,2) = price_BS - price(i,2);
    time(i,2) = cputime-start;
end
sample_size_mc(2) = sample_size(mean(variance(:,2)));

% Control variates
g = @(S) S;
for i = 1:M
   	start = cputime;
    gm = S0.*exp(r*T);
    gv = S0.^2.*exp(2*r*T)*(exp(sigma^2*T)-1);
    ST = S0.*exp((r-0.5*sigma^2)*T+sigma*sqrt(T).*X);
    covariance_matrix = cov(payoff(ST),ST);
    c = covariance_matrix(1,2)/var(ST);
    fcv = var(payoff(ST))*(1-(covariance_matrix(1,2))^2/(var(payoff(ST))*var(g(ST))));
    fc = payoff(ST)-c.*(g(ST)-gm);
    price(i,3) = mean(fc);
    variance(i,3) = var(fc);
    errors(i,3) = price_BS - price(i,3);
    time(i,3) = cputime-start;
end
sample_size_mc(3) = sample_size(mean(variance(:,3)));

% Importance sampling
for i = 1:M
    time(i,4) = cputime;
    y0 = normcdf((log(K1./S0)-(r-0.5*sigma^2)*T)/(sigma*sqrt(T)));
    Y = y0 + (1-y0).*rand(1,N);
    X = norminv(Y);
    ST = S0.*exp((r-0.5*sigma^2)*T+sigma*sqrt(T).*X);
    ST(ST==Inf)=0;
    price(i,4) = mean((1-y0)*mean(payoff(ST)));
    variance(i,4) = mean((1-y0).^2*var(payoff(ST)));
    errors(i,4) = price_BS - price(i,4);
    time(i,4) = cputime-start;
end
sample_size_mc(4) = sample_size(mean(variance(:,4)));



