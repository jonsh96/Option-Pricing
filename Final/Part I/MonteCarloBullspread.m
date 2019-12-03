function [times, prices, variances, errors, sample_sizes] = MonteCarloBullspread(Smin, Smax, K1, K2, rate, volatility, T, M, payoff, BS_bullspread)

    % INPUTS:
    %   - M:            Number of Monte Carlo simulations
    %
    % OUTPUTS:
    %   - times:        CPU times required to run each of the methods
    %   - prices:       Option prices as a function of stock price each of the methods 
    %   - variances:    Variances from each of the methods
    %   - errors:       
    %   - sample_sizes: 
    
    S0 = Smin:Smax;
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;

    prices = zeros(4,Smax);
    variances = zeros(4,Smax);
    errors = zeros(4,Smax);
    times = zeros(4,1);
    sample_sizes = zeros(4, Smax);

    % Naive method
    ST = zeros(Smax,M);
    dW = sqrt(T)*randn(Smax,M);

    start = cputime;
    for i = 1:Smax
        ST(i,:) = S0(i)*exp((rate-0.5*volatility^2)*T+volatility.*dW(i,:));
        prices(1,i) = mean(payoff(ST(i,:)));
        variances(1,i) = var(payoff(ST(i,:)));
        errors(1,i) = BS_bullspread(i) - prices(1,i);   
    end
    times(1) = (cputime-start)/Smax;
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    
    % Antithetic variance reduction
    start = cputime;
    ST = zeros(Smax, M);
    Splus = zeros(Smax, M);
    Sminus = zeros(Smax, M);
    for i = 1:Smax
        ST(i,:) = S0(i)*exp((rate-0.5*volatility^2)*T+volatility.*dW(i,:));
        Splus(i,:) = S0(i)*exp((rate-0.5*volatility^2)*T+volatility.*dW(i,:));
        Sminus(i,:) = S0(i)*exp((rate-0.5*volatility^2)*T-volatility.*dW(i,:));
        Z = (payoff(Splus(i,:))+payoff(Sminus(i,:)))/2;
        prices(2,i) = mean(Z);
        variances(2,i) = var(Z);
        errors(2,i) = payoff(i) - prices(2,i);   % bullspread -> BS_payoff
    end
    times(2) = (cputime-start)/Smax;
    sample_sizes(2,:) = confidence_sample(variances(2,:));


    % Control variates
    start = cputime;
    g = @(S) S;
    f = @(S) payoff(S);
    dW = sqrt(T)*randn(Smax);

    for i = 1:Smax
        gm = S0(i)*exp(rate*T);
%       gv = S0(i)^2*exp(2*r*T)*(exp(sigma^2*T)-1);
        
        ST = S0(i)*exp((rate-0.5*volatility^2)*T+volatility.*dW(i,:));
        covariance_matrix = cov(f(ST),ST);
        c = covariance_matrix(1,2)/var(ST);
%       fcv = var(f(ST))*(1-(covariance_matrix(1,2))^2/(var(f(ST))*var(g(ST))));
        fc = f(ST)-c*(g(ST)-gm);
        
        prices(3,i) = mean(fc);
        variances(3,i) = var(fc);
        errors(3,i) = payoff(i) - prices(3,i);
    end
    times(3) = (cputime-start)/Smax;

    sample_sizes(3,:) = confidence_sample(variances(3,:));

    % Importance sampling
    start = cputime;
    for i = 1:Smax
        y0 = normcdf((log(K1/S0(i))-(rate-0.5*volatility^2)*T)/(volatility*sqrt(T)));
        Y = y0 + (1-y0)*rand(1,M);
        X = norminv(Y);
        ST = S0(i)*exp((rate-0.5*volatility^2)*T+volatility*sqrt(T)*X);
        ST(ST==Inf) = 0; % SET ALL ST = INF TO ZERO 
        fST = (1-y0)*exp(-rate*T).*(ST-K1-max(ST-K2,0));
        prices(4,i) = mean(fST);
        variances(4,i) = var(fST);
        errors(4,i) = payoff(i) - prices(4,i);
    end
    times(4) = (cputime-start)/Smax;
    sample_sizes(4,:) = confidence_sample(variances(4,:));
    
end