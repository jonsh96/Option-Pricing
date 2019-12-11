function BarrierDeltaComparison(Smin, Smax, rate, volatility, dt, T, M, option_payoff)
    % INPUTS: 
    %   - Smin:             Minimum stock prices
    %   - Smax:             Maximum stock prices
    %   - rate:             Interest rate (constant or function_handle)
    %   - volatility:       Volatility (constant or function_handle)
    %   - dt:               Time step
    %   - T:                Time to maturity
    %   - M:                Number of Monte Carlo simulations
    %   - option_payoff:    Option payoff (function_handle)
    %
    % ABOUT: 
    %   - Plots the option's delta for a few barrier prices, 0 and 5:8:45
    
    figure
    leg = [];
    for i = 5:8:45
        if(nargin(option_payoff) == 1)
            delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff, 0);
        else
            delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff, i);
        end
        plot(delta,'LineWidth',1.5)
        hold on
        leg = [leg, sprintf("Barrier option with S_b = £%d",i)];
    end
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Option delta (\Delta)','FontSize',14)
    xlim([Smin, Smax])
    legend(leg,'FontSize',14)
end
