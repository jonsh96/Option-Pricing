function J = MinimizeAbsError(K1, K2, T, rate, sigma, Smin, Smax, N, option_price)
    % INPUTS: 
    %   - K1:           Strike price of the long call option
    %   - K2:           Strike price of the short call option
    %   - T:            Time to maturity (in years)
    %   - rate:         Risk free interest rates (in decimals)
    %   - sigma:        Volatility (in decimals)
    %   - Smin:         Lowest value of the stock price
    %   - Smax:         Highest value of the stock price
    %   - N:            Number of time steps
    %   - option_price: Black Scholes solution of the bull call spread 
    %                   (function_handle)
    % OUTPUTS: 
    %   - J:            Number of grid points needed for a given N such
    %                   that the maximum absolute error is < 0.05
    % 
    % ABOUT: 
    %   - Finds J for a given value of N such that the absolute error < 0.05, i.e. 
    %                          ||V_PDE - V_BS|| < 0.05
    
    disp("Finding J such that the absolute error of ||V_PDE - V_BS|| < 0.05")
    % Set the initial error value to infinity to start the while-loop looking for 
    error = Inf;    
    % Make an initial guess about the value of J 
    J = round(N/10);
    
    % Run the while loop until the error is < 0.05
    while(error > 0.05)
        % J increases by one with every iteration
        J = J+1;    
        % Compare the values of the numerical solution with the
        % Black-Scholes solution
        [V_PDE, S] = PDE_bullspread(K1, K2, T, rate, sigma, Smin, Smax, N, J);
        V_BS = option_price(S);    
        % We use the same S values for V_PDE and V_BS because they are not
        % uniformly distributed between Smin and Smax
        
        % The maximum absolute error is calculated
        error = norm(V_PDE-V_BS,Inf);   
    end
    fprintf("Minimum J found: %d\t\n",J);
    fprintf("Error at N = %d, J = %d is %.4f\n",N, J, error);
end