function ErrorSurfacePlot(Smin, Smax, K1, K2, T, rate, volatility, option_price);
    % INPUTS: 
    %   - K1:    Strike price of the long call option
    %   - K2:    Strike price of the short call option
    %   - T:     Time to maturity (in years)
    %   - r:     Risk free interest rates (in decimals)
    %   - sigma: Volatility (in decimals)
    %   - Smin:  Lowest value of the stock price
    %   - Smax:  Highest value of the stock price
    %
    % ABOUT:
    %   - Plots the surface plot of the maximum absolute error as a
    %     function of the number of time steps and grid points
    
    error = zeros(Smax, Smax);
    for N = Smin:Smax
        for J = Smin:Smax
            [V_PDE, S_PDE] = PDE_bullspread(K1, K2, T, rate, volatility, Smin, Smax, N, J);
            V_BS = option_price(S_PDE); 
            error(N,J) = norm(V_PDE-V_BS,Inf);
        end
    end

    mesh(error)
    xlabel('Number of time steps','FontSize',14)
    ylabel('Number of grid points','FontSize',14)
    zlabel('Maximum absolute error','FontSize',14)
end