function plotMonteCarlo(Smin, Smax, prices, BS_bullspread)
    % INPUTS: BREYTA ÞESSUUUUUUUUUUUUUUUUUU
    %   - S:     Range of stock prices
    %   - V_PDE: Numerical solution of option prices as a function of stock price 
    %   - V_BS:  Black-Scholes solution of option prices as a function of stock price 
    %
    % AUTHOR:   
    %   - Jón Sveinbjörn Halldórsson 20/11/2019
    %
    % ABOUT: 
    %   - Plots a comparison of the option prices derived from the
    %     numerical solution and the Black-Scholes formula
    
    figure
    for i = 1:4
        scatter(Smin:Smax,prices(i,:),'filled')
        hold on
    end
    plot(Smin:Smax,BS_bullspread(Smin:Smax),'k-','LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    ylim([min(min(prices)) max(max(prices))*1.2])
    legend('Naive method','Antithetic variance reduction', 'Control variate','Importance sampling','Black-Scholes solution','FontSize',14)
end 