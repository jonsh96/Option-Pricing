function ErrorAnalysis(K1, K2, T, r, sigma, Smin, Smax, N, J, option_price)
    % INPUTS:       
    %   - K1:               Lower strike price in bull spread
    %   - K2:               Upper strike price in bull spread
    %   - T:                Time to maturity (in years) 
    %   - r:                (Constant) interest rates
    %   - sigma:            (Constant) volatility
    %   - Smin:             Minimum value of the stock price
    %   - Smax:             Maximum value of the stock price
    %   - N:                Number of time steps
    %   - J:                Number of grid points needed for a given N such
    %                       that the maximum absolute error is < 0.05
    %
    % ABOUT: 
    %   - Plots the absolute maximum error of the option price
    %     compared to the Black Scholes solution as a function of stock price

    error = zeros(1,Smax-Smin);
    for i = Smin+1:Smax
        [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, i, N, J);
        V_BS = option_price(S); 
        error(i-1) = norm(V_PDE-V_BS,Inf);
    end
    figure
    plot(2:200,error,'-','LineWidth',2)
    grid on
    xlim([2 200])
    xlabel('Maximum stock price (£)','FontSize',14)
    ylabel('Maximum error in option price (£)','FontSize',14)
end