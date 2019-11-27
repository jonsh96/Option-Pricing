function plotDifference(Smin, Smax, prices, p, BS_bullspread)
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

    scatter(Smin:Smax,prices(p,Smin:Smax),'r','filled')
    hold on
    plot(Smin:Smax,BS_bullspread(Smin:Smax),'k-','LineWidth',1.5)
    grid on
    for i = Smin:Smax
       plot([i i], [min(BS_bullspread(i),prices(p,i)) max(BS_bullspread(i),prices(p,i))],'r-')
    end
    hold off
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option price (£)','FontSize',14)
    legends = ["Naive method"; "Antithetic variance reduction"; "Control variate"; "Importance sampling"];
    legend('Black-Scholes solution', legends(p),'FontSize',14)
end 