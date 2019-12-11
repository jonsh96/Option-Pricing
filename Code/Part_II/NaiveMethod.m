function [times, prices, variances, sample_sizes] = NaiveMethod(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier)
    % INPUTS:
    %   - K1:               Lower strike price of the bull call spread
    %   - K2:               Upper strike price of the bull call spread
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
    %   - Naive Method
    %       - Measures the average CPU time
    %       - Calculates the option price, variance and sample size
    %         required for the desired accuracy
    
    % Function handle used to calculate the number simulations required for
    % the desired accuracy of error < 0.05 pounds with a 95% accuracy
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
    
    % Defining number of time steps 
    Nsteps = T/dt;
    t = 0:dt:T;
    % Preallocating memory for the matrices
    S = zeros(M, Nsteps+1);
    prices = zeros(1,Smax);
    variances = zeros(1,Smax);
    sample_sizes = zeros(1, Smax);

    % Naive method
    start = cputime;
    for S0 = 1:Smax
        dW = sqrt(dt)*randn(M,Nsteps);
        S = zeros(M, Nsteps+1);
        
        S(:,1) = S0;

        if(nargin(option_payoff) == 1)
            if(isa(rate,'function_handle'))
                for j = 1:Nsteps
                    S(:, j+1) = S(:, j) .* (1 + rate(t(j))*dt + volatility(S(:, j), t(j)).* dW(:, j));
                end
                Z = exp(-integral(rate,0,T))*option_payoff(S);
            else
                for j = 1:Nsteps
                    S(:, j+1) = S(:, j) .* (1 + rate*dt + volatility.* dW(:, j));
                end
                Z = exp(-rate*T)*option_payoff(S);
            end
        else
            if(isa(rate,'function_handle'))
                for j = 1:Nsteps
                    S(:, j+1) = S(:, j) .* (1 + rate(t(j))*dt + volatility(S(:, j), t(j)).* dW(:, j));
                end
                Z = exp(-integral(rate,0,T))*option_payoff(S,barrier);
            else
                for j = 1:Nsteps
                    S(:, j+1) = S(:, j) .* (1 + rate*dt + volatility.* dW(:, j));
                end
                Z = exp(-rate*T)*option_payoff(S, barrier);
            end
        end
        prices(1,S0) = mean(Z);
        variances(1,S0) = var(Z);
    end
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    % Average the CPU time for accurate result
    times = (cputime-start)/Smax;
end