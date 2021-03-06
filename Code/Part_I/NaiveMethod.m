function [times, prices, variances, sample_sizes] = NaiveMethod(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier)
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
    %   - barrier:          Barrier price (used in part II)
    %
    % OUTPUTS:
    %   - times:            CPU times required to run each of the methods
    %   - prices:           Option prices as a function of stock price each of the methods 
    %   - variances:        Variances from each of the methods
    %   - sample_sizes:     
    %
    % About:
    %   - Naive Method
    %       - Measures the average CPU time
    %       - Calculates the option price, variance and sample size
    %         required for the desired accuracy
    
    % Function handle used to calculate the number simulations required for
    % the desired accuracy of error < 0.05 pounds with a 95% accuracy
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
    
    % Defining number of time steps 
    Nsteps = T/dt;
    
    % Preallocating memory for the matrices
    S = zeros(M, Nsteps+1);
    prices = zeros(1,Smax);
    variances = zeros(1,Smax);
    sample_sizes = zeros(1, Smax);

    % Naive method
    start = cputime;
    for i = 1:Smax
        for j = 1:M
            % Generates M Geometric Brownian motion stock prices
            S(j,:) = GeometricBrownianMotion(i,rate,volatility,dt,T);
        end
        % If the number of input arguments of option_payoff is 1, then it
        % has no barrier (part I) 
        if(nargin(option_payoff) == 1)
            prices(1,i) = mean(option_payoff(S));
            variances(1,i) = var(option_payoff(S));
        else
            % Otherwise we calculate the option_payoff with a barrier 
            % used in (part II)
            prices(1,i) = mean(option_payoff(S,barrier));
            variances(1,i) = var(option_payoff(S,barrier));
        end
    end
    % Calculate the sample size
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    % Average the CPU time for accurate result
    times = (cputime-start)/(Smax*M);
end