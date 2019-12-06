function PlotResults(sample_sizes)
    % TODO: COMMENT
    % INPUTS: 
    %   - sample_sizes: Volatility (in decimals)
    
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

