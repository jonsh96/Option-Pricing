function PlotMonteCarlo(Smin, Smax, prices, option_price)
    % INPUTS: 
    %   - Smin:             Minimum stock prices
    %   - Smax:             Maximum stock prices
    %   - prices:           Option prices determined by the four Monte Carlo methods
    %   - option_prices:    Black-Scholes solution of the bull call spread
    %                       (function handle)
    %
    % ABOUT: 
    %   - Plots a comparison of the option prices derived from the
    %     numerical solution and the Black-Scholes formula
    
    % Cell array of four different shapes
    col={'-o', '-d', '-x', '-*'};   
    figure
    for i = 1:4
        plot(Smin:Smax,prices(i,:),col{i})
        hold on
    end
    plot(Smin:Smax,option_price(Smin:Smax),'k-','LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    ylim([min(min(prices)) max(max(prices))*1.2])
    legend('Naive method','Antithetic variance reduction', 'Control variate','Importance sampling','Black-Scholes solution','FontSize',14)
end 