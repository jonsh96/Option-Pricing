function PlotComparison(S_PDE, V_PDE, V_BS)
    % INPUTS: 
    %   - S_PDE: Range of stock prices (output from the heat equation
    %            transformation
    %   - V_PDE: Numerical solution of option prices as a function of stock price 
    %   - V_BS:  Black-Scholes solution of option prices as a function of stock price 
    %
    % ABOUT: 
    %   - Plots a comparison of the option prices derived from the
    %     numerical solution and the Black-Scholes formula
    
    disp('Plotting the comparison of the numerical solution and the Black-Scholes solution')
    figure
    plot(S_PDE,V_BS,'b--','LineWidth',2)
    hold on
    plot(S_PDE,V_PDE,'ro','LineWidth',2)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    legend('Black-Scholes solution','Numerical solution', 'FontSize',14)
end 