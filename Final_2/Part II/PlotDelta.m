function PlotDelta(Smin, Smax, delta)
    plot(Smin:Smax, delta)
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option delta (\Delta)','FontSize',14)
end