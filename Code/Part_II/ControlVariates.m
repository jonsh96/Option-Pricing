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
    
    % Initialise the matrices
    S = zeros(M, Nsteps+1);    
    Sc = zeros(M, Nsteps+1);
    
    % Initialising parameters
    t = 0:dt:T;
    K = 50;
    r0 = 0.05;
    sigma0 = 0.3;
    
    start = cputime;
    
    for S0 = Smin:Smax
        dW = sqrt(dt)*randn(M, Nsteps);    

        % Setting the initial stock price
        S(:, 1) = S0;   
        Sc(:, 1) = S0;   
        
        % Local volatility and time-dependent interest rates
        if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
            Sc(1:end, 1) = S0;
            for j = 1:Nsteps
                % Simulate S and Sconst
                S(:, j+1) = S(:, j) .* (1 + rate(t(j))*dt + volatility(S(:, j),t(j)).* dW(:, j));
                Sc(:, j+1) = Sc(:, j) .* (1 + r0*dt + sigma0.*dW(:, j));
            end
            gm = S0*exp(r0*T);
            gv = (gm^2)*(exp(sigma0^2*T)-1); 
            if(nargin(option_payoff) == 1)
                fST = exp(-integral(rate,0,T))*option_payoff(S);
            else
                fST = exp(-integral(rate,0,T))*option_payoff(S,barrier); 
            end
            covfg = cov(fST, Sc(:,end));
            c =  covfg(1, 2)/gv;
            fc = fST-c*(Sc(:,end)-gm); 
        else
            % Constant volatility and interest rates
            S(1:end, 1) = S0;
            for j = 1:Nsteps
                S(1:end, j+1) = S(1:end, j) .* (1 + r0*dt + sigma0.*dW(1:end, j));
            end
            gm = S0*exp(r0*T);
            gv = (gm^2)*(exp(sigma0^2*T)-1); 
            if(nargin(option_payoff) == 1)
                fST = exp(-r0*T)*option_payoff(S);
            else
                fST = exp(-r0*T)*option_payoff(S,barrier);
            end
            
            cov_fST_ST = cov(fST, S(:,end));
            c =  cov_fST_ST(1, 2)/gv;
            fc = fST-c*(S(:,end)-gm);     
        end
        % Calculating price and variance
        prices(1,S0) = mean(fc);
        variances(1,S0) = var(fc);
    end
    
    % Calculating sample sizes and measuring CPU time
    sample_sizes(1,:) = confidence_sample(variances(1,:));
    times = (cputime-start)/Smax;
end