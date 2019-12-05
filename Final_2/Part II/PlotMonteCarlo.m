function PlotMonteCarlo(Smin, Smax, prices, option_price)
    % INPUTS: 
    %   - Smin:             Minimum stock prices
    %   - Smax:             Maximum stock prices
    %   - prices:           Option prices determined by the four Monte Carlo methods
    %   - option_prices:    Black-Scholes solution of the vanilla
    %                       put/barrier option (function handle)
    %
    % ABOUT: 
    %   - Plots a comparison of the option prices derived from the
    %     numerical solution and the Black-Scholes formula
    
    % Cell array of four different shapes
    col={'o', 'd', '+', '*'};   
    figure
    for i = 1:3
        plot(Smin:Smax,prices(i,:),col{i})
        hold on
    end
    plot(option_price,'k--','LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    xlim([Smin Smax])
    legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
end 