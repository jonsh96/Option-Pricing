function [times, prices, variances, sample_sizes] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price)
    % INPUTS:
    %   - K1:               Lower strike price of the vanilla put/barrier option
    %   - K2:               Upper strike price of the vanilla put/barrier option
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
    %   - Antithetic variance reduction
    %       - Measures the average CPU time
    %       - Calculates the option price, variance and sample size
    %         required for the desired accuracy
    
    % Function handle used to calculate the number simulations required for
    % the desired accuracy of error < 0.05 pounds with a 95% accuracy
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
    
    % Defining the number of time steps 
    Nsteps = T/dt;
    
    % Preallocating memory for the matrices
    prices = zeros(1,Smax);
    variances = zeros(1,Smax);
    sample_sizes = zeros(1, Smax);
    
    start = cputime;
    for i = 1:Smax
        S = zeros(M, Nsteps+1);
        Splus = zeros(M, Nsteps+1);
        Sminus = zeros(M, Nsteps+1);
        for j = 1:M
            [S(j,:), Splus(j,:), Sminus(j,:)] = GeometricBrownianMotion(i,rate,volatility,dt,T);
        end
        Z = (option_payoff(Splus(:,end)) + option_payoff(Sminus(:,end)))/2;
        prices(1,i) = mean(Z);
        variances(1,i) = var(Z);
    end
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    times = (cputime-start)/Smax;
end    