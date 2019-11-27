function J = minimizeAbsError(K1, K2, T, r, sigma, Smin, Smax, N, BS_bullspread)
    % INPUTS: 
    %   - K1:    Strike price of the long call option
    %   - K2:    Strike price of the short call option
    %   - T:     Time to maturity (in years)
    %   - r:     Risk free interest rates (in decimals)
    %   - sigma: Volatility (in decimals)
    %   - Smin:  Lowest value of the stock price
    %   - Smax:  Highest value of the stock price
    %   - N:     Number of time steps
    %   
    % OUTPUTS: 
    %   - J:     Number of grid points
    % 
    % ABOUT: 
    %   - Finds J for a given value of N such that the absolute error < 0.05, i.e. 
    %                          ||V_PDE - V_BS|| < 0.05
    % 
    % AUTHOR: 
    %   - Jón Sveinbjörn Halldórsson 22/11/2019
    
    disp("Finding J such that the absolute error of ||V_PDE - V_BS|| < 0.05")
    % Set the initial error value to infinity to start the while-loop looking for 
    error = Inf;    
    % Make an initial guess about the value of J 
    J = round(N/10);
    
    % Run the while loop until the error is < 0.05
    while(error >= 0.05)
        % J increases by one with every iteration
        J = J+1;    
        % Compare the values of the numerical solution with the
        % Black-Scholes solution
        [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
        V_BS = BS_bullspread(S);    
        % We use the same S values for V_PDE and V_BS because they are not
        % uniformly distributed between Smin and Smax
        
        % The maximum absolute error is calculated
        error = norm(V_BS-V_PDE,Inf);   
    end
end