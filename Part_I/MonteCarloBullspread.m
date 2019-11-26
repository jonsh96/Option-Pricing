%function [times, prices, variances, errors, sample_sizes] = MonteCarloBullspread(Nr)
    % INPUTS:
    %   - M:            Number of Monte Carlo simulations
    %
    % OUTPUTS:
    %   - times:        CPU times required to run each of the methods
    %   - prices:       Option prices as a function of stock price each of the methods 
    %   - variances:    Variances from each of the methods
    %   - errors:       
    %   - sample_sizes: 
    
set_parameters;
Smax = 200;

S0 = Smin:Smax;
sample_size = @(v) (sqrt(v)*1.96/0.05)^2;

Nr = 130; % Number of simulations per stock price
price = zeros(4,Smax);
variance = zeros(4,Smax);
errors = zeros(4,Smax);
time = zeros(4,Smax);
sample_size_mc = zeros(1,4);

% Naive method
for i = 1:Smax
    start = cputime;
    dW = sqrt(T)*randn(Nr,Smax);
    ST = zeros(Nr,Smax);
    for j = 1:Nr
        ST(j,i) = S0(i)*exp((r-0.5*sigma^2)*T+sigma*dW(j,i)); 
    end
    price(1,i) = mean(payoff(ST(:,i)));
    variance(1,i) = mean(var(ST));
    errors(1,i) = bullspread(i) - price(1,i);   % bullspread -> BS_payoff
    time(1,i) = cputime-start;
end
sample_size_mc(1) = sample_size(mean(variance(1,:)));

% Antithetic variance reduction
for i = 1:Smax
    start = cputime;
    dW = sqrt(T)*randn(Nr,Smax);
    Splus = zeros(Nr,Smax);
    Sminus = zeros(Nr,Smax);
    for j = 1:Nr
        Splus(j,i) = S0(i)*exp((r-0.5*sigma^2)*T+sigma*dW(j,i)); 
        Sminus(j,i) = S0(i)*exp((r-0.5*sigma^2)*T-sigma*dW(j,i)); 
    end
    Z = (payoff(Splus(:,i))+payoff(Sminus(:,i)))/2;
    price(2,i) = mean(Z);
    variance(2,i) = var(Z);
    errors(2,i) = bullspread(i) - price(2,i);   % bullspread -> BS_payoff
    time(2,i) = cputime-start;
end
sample_size_mc(2) = sample_size(mean(variance(:,2)));


% Control variates
g = @(S) S;
f = @(S) payoff(S);
for i = 1:Smax
   	start = cputime;
    gm = S0(i)*exp(r*T);
    gv = S0(i)^2*exp(2*r*T)*(exp(sigma^2*T)-1);
    dW = sqrt(T)*randn(Nr,Smax);
    ST = zeros(Nr,Smax);

    fc = zeros(Nr,Smax);
    for j = 1:Nr
        ST = S0(i)*exp((r-0.5*sigma^2)*T+sigma.*dW(j,:));
        covariance_matrix = cov(f(ST),ST);
        c = covariance_matrix(1,2)/var(ST);
        fcv = var(f(ST))*(1-(covariance_matrix(1,2))^2/(var(f(ST))*var(g(ST))));
        fc(j,:) = f(ST)-c*(g(ST)-gm);
    end
    price(3,i) = mean(fc(:,i));
%     var_cv = var(fc);
    time(3,i) = cputime-start;
end

% Importance sampling
for i = 1:Smax
    y0 = normcdf((log(K1/S0(i))-(r-0.5*sigma^2)*T)/(sigma*sqrt(T)));
    Y = y0 + (1-y0)*rand(1,Smax);
    X = norminv(Y);
    ST = S0(i)*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*X);
    f = exp(-r*T).*(ST-K1-max(ST-K2,0));
    price(4,i) = (1-y0)*mean(f)
    %var_is = (1-y0)^2*var(f);
end
%% COMPARISON
% V_MC = price(1,:);
scatter(1:200,price(1,:),'filled')
hold on
scatter(1:200,price(2,:),'filled')
scatter(1:200,price(3,:),'filled')
scatter(1:200,price(4,:),'filled')
plot(bullspread(1:Smax),'k-','LineWidth',4)
grid on
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
legend('Naive method','Antithetic variance reduction', 'Control variate','Importance sampling','Black-Scholes solution','FontSize',14)