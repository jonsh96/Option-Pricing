function PlotDelta(Smin, Smax, delta)
    plot(Smin:Smax, delta,'LineWidth',1.5)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option delta (\Delta)','FontSize',14)
end