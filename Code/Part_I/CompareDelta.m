function CompareDelta(S_PDE, delta, option_delta)
    % INPUTS:   
    %   - S_PDE:        Stock prices (solution from heat equation)
    %   - V_PDE:        Option prices (solution from heat equation)
    %   - delta:        The option's finite difference delta
    %   - option_delta: The option's delta calculated with blsdelta
    %                   (function_handle)
    %
    % ABOUT:
    %   - Plots the difference between the Black Scholes delta and the
    %     forward method finite difference delta.
    figure
    plot(S_PDE(1:end-1),delta, 'r-o','LineWidth',1.5)
    hold on
    plot(S_PDE(1:end-1), option_delta(S_PDE(1:end-1)), 'k-o','LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Delta (\Delta)','FontSize',14)
    legend('Numerical solution','Black Scholes solution', 'FontSize',14)
end