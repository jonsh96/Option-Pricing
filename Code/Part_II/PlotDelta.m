function PlotDelta(Smin, Smax, delta)
    % INPUTS:
    %  - Smin:  Minimum stock price
    %  - Smax:  Maximum stock price
    %  - Delta: Numerical solution of delta
    % 
    % ABOUT:
    %  - Plots delta
    
    plot(Smin:Smax, delta,'LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option delta (\Delta)','FontSize',14)
end