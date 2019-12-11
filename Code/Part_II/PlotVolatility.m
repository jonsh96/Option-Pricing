function PlotVolatility(Smin, Smax, T, volatility)
    % INPUTS:
    %   - Smin:         Minimum stock price
    %   - Smax:         Maximum stock price
    %   - T:            Time to maturity
    %   - volatility:   Local volatility model (function handle)
    %
    % ABOUT:
    %   - Plots the surface of the local volatility model
    figure
    fsurf(volatility, [Smin Smax 0 T]);
    xlabel('Stock price', 'FontSize', 18)
    ylabel('Time to maturity', 'FontSize', 18)
    zlabel('Volatility', 'FontSize', 18)
end