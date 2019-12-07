function PlotSampleSizes(sample_sizes)
   % INPUTS: 
    %   - times:            CPU times of the four Monte Carlo methods
    %   - prices:           Option prices calculated by the four Monte Carlo methods
    %   - variances:        Variances of the solution from Monte Carlo methods
    %   - sample_sizes:     Sample sizes for each Monte Carlo methods for each
    %                       stock price
    % 
    % ABOUTS:   
    %  - Plots the comparison of the sample sizes needed for each stock price
    %    to get the desired accuracy
    
    figure
    for i = 1:4
        plot(sample_sizes(i,:))
        hold on
    end
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Sample size needed for 95% accuracy','FontSize',14)
    legend('Naive method','Antithetic variance reduction', 'Control variate','Importance sampling','FontSize',14)
end