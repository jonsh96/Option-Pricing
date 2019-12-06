function PlotVolatility(Smin, Smax, T, volatility)
    % TODO: COMMENT
    fsurf(volatility, [Smin Smax 0 T]);
    xlabel('Stock price', 'FontSize', 18)
    ylabel('Time to maturity', 'FontSize', 18)
    zlabel('Volatility', 'FontSize', 18)
end