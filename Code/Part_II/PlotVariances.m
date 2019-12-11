function PlotVariances(Smin, Smax, variances, barrier)
    % INPUTS: 
    %   - Smin:         Minimum stock price
    %   - Smax:         Maximum stock price
    %   - variances:    Variances obtained by Monte Carlo simulations
    %   - barrier:      (Optional) Barrier price
    %
    % ABOUT:
    %   - Plots the variance for each of the Monte Carlo methods.
    
    figure
    for i = 1:3
        plot(variances(i,:),'LineWidth',1.5)
        hold on
    end
    grid on
    xlim([barrier, Smax])
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Variance','FontSize',14)
    legend('Naive method','Antithetic variance reduction', 'Control variate','FontSize',14)
end

