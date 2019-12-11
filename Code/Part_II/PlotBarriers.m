function PlotBarriers(Smin, Smax, prices, barrier)
    % INPUTS: 
    %   - Smin:             Minimum stock prices
    %   - Smax:             Maximum stock prices
    %   - prices:           Option prices determined by the four Monte Carlo methods
    %   - barrier:          Plot the graphs starting from the barrier, if
    %                       barrier is set to 0 then from Smin
    %
    % ABOUT: 
    %   - Plots a comparison of the option prices derived from the
    %     numerical solution and the Black-Scholes formula
    
    plot(Smin:Smax,prices(Smin:Smax),'LineWidth',1.5)
    hold on
    xlim([Smin, Smax])
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)

end 