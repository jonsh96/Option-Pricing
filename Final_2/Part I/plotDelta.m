function PlotDelta(Smin, Smax, delta, option_delta)
    plot(delta,'r-d','LineWidth',2)
    hold on
    plot(Smin:Smax, option_delta(Smin:Smax),'k','LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Delta value (\Delta)','FontSize',14)
    legend('Numerical solution','Black Scholes solution','FontSize',14)
end