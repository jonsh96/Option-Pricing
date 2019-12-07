function BarrierDeltaComparison(Smin, Smax, rate, volatility, dt, T, M, option_payoff)
    % TODO: COMMENT
    sp = 1; % Subplot counter
    for i = 5:8:45
        subplot(3,2,sp)
        if(nargin(option_payoff) == 1)
            delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff, 0);
        else
            delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff, i);
        end
        plot(delta)
        grid on
        titlestr = sprintf("Barrier option with S_b = £%d",i);
        title(titlestr,'FontSize',14)
        xlabel('Stock price (£)','FontSize',14)
        ylabel('Option delta (\Delta)','FontSize',14)
        xlim([Smin, Smax])
        legend('Naive method','FontSize',14)
        sp = sp + 1;
    end
end
