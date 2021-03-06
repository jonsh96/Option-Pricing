function [times, prices, variances, sample_sizes] = ControlVariates(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier)
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
    %   - barrier:          Barrier price (used in part II)
    %
    % OUTPUTS:
    %   - times:            CPU times required to run each of the methods
    %   - prices:           Option prices as a function of stock price each of the methods 
    %   - variances:        Variances from each of the methods
    %   - sample_sizes: 
    %
    % About:
    %   - Control variates
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
    g = @(S) S;
    f = @(S) option_payoff(S);

    for i = 1:Smax
        gm = i*exp(rate*T);
        gv = gm^2*(exp(volatility^2*T)-1);
        
        S = zeros(M, Nsteps+1);
        Splus = zeros(M, Nsteps+1);
        Sminus = zeros(M, Nsteps+1);
        
        for j = 1:M
            [S(j,:), Splus(j,:), Sminus(j,:)] = GeometricBrownianMotion(i,rate,volatility,dt,T);
        end
        covariance_matrix = cov(f(S(:,end)),S(:,end));
        c = covariance_matrix(1,2)/gv;
        fc = f(S(:,end))-c*(g(S(:,end))-gm);
        prices(1,i) = mean(fc);
        variances(1,i) = var(fc);
    end
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    times = (cputime-start)/(Smax*M);
end    