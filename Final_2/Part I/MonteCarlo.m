function [times, prices, variances, sample_sizes] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price, barrier)
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
    % ABOUT:
    %   - Running the four Monte Carlo methods 
    %       - Measures the average CPU time
    %       - Calculates the option price, variance and sample size
    %         required for the desired accuracy
    
    % Preallocating memory for the matrices
    prices = zeros(4,Smax);
    variances = zeros(4,Smax);
    times = zeros(4,1);
    sample_sizes = zeros(4, Smax);

    % Naive method
    [times(1), prices(1,:), variances(1,:), sample_sizes(1,:)] = NaiveMethod(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier);
    
    % Antithetic variance reduction
    [times(2), prices(2,:), variances(2,:), sample_sizes(2,:)] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier);

    % Control variates
    [times(3), prices(3,:), variances(3,:), sample_sizes(3,:)] = ControlVariates(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier);
    
    % Importance sampling
    [times(4), prices(4,:), variances(4,:), sample_sizes(4,:)] = ImportanceSampling(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff);
end