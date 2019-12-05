function plotResults(times, prices, variances, sample_sizes)
   % INPUTS: 
    %   - times:        
    %   - prices:       Strike price of the short call option
    %   - variances:    Time to maturity (in years)
    %   - errors:       Risk free interest rates (in decimals)
    %   - sample_sizes: Volatility (in decimals)
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
    
    figure
    for i = 1:3
        plot(sample_sizes(i,:))
        hold on
    end
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Sample size needed for 95% accuracy','FontSize',14)
    legend('Naive method','Antithetic variance reduction', 'Control variate','FontSize',14)
end