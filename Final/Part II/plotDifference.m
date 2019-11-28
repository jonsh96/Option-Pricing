function plotDifference(Smin, Smax, MC, BS)
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

    scatter(Smin:Smax, MC,'r','filled')
    hold on
    plot(Smin:Smax, BS(Smin:Smax),'k-','LineWidth',1.5)
    grid on
    for i = Smin:Smax
       plot([i i], [min(BS(i),MC(i)) max(BS(i),MC(i))],'r-')
    end
    hold off
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    
    legend('Monte Carlo solution', 'Black Scholes solution','FontSize',14)
end 