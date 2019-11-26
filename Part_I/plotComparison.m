function plotComparison(S, V_PDE, V_BS)
    % INPUTS: 
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
    
    plot(S,V_PDE,'b-')
    hold on
    plot(S,V_BS,'r*')
    grid on
    xlabel('Stock price (£)','FontSize',12)
    ylabel('Option price (£)','FontSize',12)
    legend('Numerical solution','Black-Scholes solution','FontSize',12)
end 