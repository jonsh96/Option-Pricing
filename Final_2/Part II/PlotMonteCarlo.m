function PlotMonteCarlo(Smin, Smax, prices, barrier)
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
    
    % Cell array of four different shapes
    col={'o', 'd', '+', '*'};   
    figure
    for i = 1:3
        plot(Smin:Smax,prices(i,Smin:Smax),col{i},'LineWidth',1.5)
        hold on
    end
    xlim([barrier, Smax])
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
end 