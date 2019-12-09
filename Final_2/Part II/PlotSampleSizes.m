function PlotSampleSizes(Smin, Smax, sample_sizes, barrier)
    % TODO: COMMENT
    % INPUTS: 
    %   - sample_sizes: Volatility (in decimals)
    
    figure
    for i = 1:3
        plot(sample_sizes(i,:),'LineWidth',1.5)
        hold on
    end
    grid on
    xlabel('Stock price (�)','FontSize',14)
    ylabel('Sample size needed for 95% accuracy','FontSize',14)
    legend('Naive method','Antithetic variance reduction', 'Control variate','FontSize',14)
end

