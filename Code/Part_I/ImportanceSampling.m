function [times, prices, variances, sample_sizes] = ImportanceSampling(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price)
    % INPUTS:
    %   - K:                Value (or array) of strike prices
    %   - Smin:             Lowest value of the stock price
    %   - Smax:             Highest value of the stock price
    %   - rate:             Interest rates (constant or a function_handle)
    %   - volatility:       Volatility (constant or local volatility model, i.e., a function_handle)
    %   - dt:               Size of time step (in years)
    %   - T:                Time to maturity (in years)
    %   - M:                Number of Monte Carlo simulations
    %   - option_payoff:    Payoff of the option (function_handle)
    %   - option_price:     Black-Scholes price of the option (function_handle)
    %
    % OUTPUTS:
    %   - times:            CPU times required to run each of the methods
    %   - prices:           Option prices as a function of stock price each of the methods 
    %   - variances:        Variances from each of the methods
    %   - sample_sizes: 
    %
    % About:
    %   - Importance sampling
    %       - Measures the average CPU time
    %       - Calculates the option price, variance and sample size
    %         required for the desired accuracy
    
    % Function handle used to calculate the number simulations required for
    % the desired accuracy of error < 0.05 pounds with a 95% accuracy
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
    
    % Preallocating memory for the matrices
    prices = zeros(1,Smax);
    variances = zeros(1,Smax);
    sample_sizes = zeros(1, Smax);
    
    start = cputime;
    for i = 1:Smax
        y0 = normcdf((log(K(1)/i)-(rate-0.5*volatility^2)*T)/(volatility*sqrt(T)));
        Y = y0 + (1-y0)*rand(1,M);
        X = norminv(Y);
        S = i*exp((rate-0.5*volatility^2)*T+volatility*sqrt(T)*X);
        % Setting all S = INF to zero 
        % - This error is caused by the norminv function
        S(S == Inf) = 0; 
        fST = (1-y0)*exp(-rate*T).*(S-K(1)-max(S-K(2),0));
        prices(1,i) = mean(fST);
        variances(1,i) = var(fST);
    end
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    times = (cputime-start)/(Smax*M);
    
end    



