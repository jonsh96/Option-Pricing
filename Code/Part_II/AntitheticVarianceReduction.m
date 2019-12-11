function [times, prices, variances, sample_sizes] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier)
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
    
    t = 0:dt:T;
    
    start = cputime;
    % Simulate for all stock prices
    for S0 = 1:Smax
        % Pre-allocating the memory
        dW = sqrt(dt)*randn(M,Nsteps);
        Splus = zeros(M, Nsteps+1);
        Sminus = zeros(M, Nsteps+1);
        
        Splus(:,1) = S0;
        Sminus(:,1) = S0;       
        
        % Simulating the paths
        if(isa(rate,'function_handle'))
            for j = 1:Nsteps
                Splus(:, j+1) = Splus(:, j) .* (1 + rate(t(j))*dt + volatility(Splus(:, j), t(j)).* dW(:, j));
                Sminus(:, j+1) = Sminus(:, j) .* (1 + rate(t(j))*dt - volatility(Sminus(:, j), t(j)).* dW(:, j));
            end
        else
            for j = 1:Nsteps
                Splus(:, j+1) = Splus(:, j) .* (1 + rate*dt + volatility.* dW(:, j));
                Sminus(:, j+1) = Sminus(:, j) .* (1 + rate*dt - volatility.* dW(:, j));
            end
        end 
        % Calculating the payoff
        if(nargin(option_payoff) == 1)
            Z = (option_payoff(Splus) + option_payoff(Sminus))/2;
        else
            Z = (option_payoff(Splus,barrier) + option_payoff(Sminus,barrier))/2;
        end
        
        % Discounting
        if(isa(rate,'function_handle'))
            Z = exp(-integral(rate,0,T))*Z; 
        else
            Z = exp(-rate*T)*Z;             
        end
        % Calculating price and variance
        prices(1,S0) = mean(Z);
        variances(1,S0) = var(Z);
    end
    % Calculating sample sizes and measuring CPU time
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    times = (cputime-start)/Smax;
end    