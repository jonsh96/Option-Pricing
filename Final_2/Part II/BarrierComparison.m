function BarrierComparison(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff)
    % TODO: COMMENT
    sp = 1; % Subplot counter
    for i = 5:8:45
        [times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff, i);
        subplot(2,3,sp);
        plot(prices(1,:))
        hold on
        plot(prices(2,:))
        plot(prices(3,:))
        grid on
        titlestr = sprintf("Constant volatility barrier option with S_b = £%d",i);
        title(titlestr,'FontSize',14)
        xlabel('Stock price (£)','FontSize',14)
        ylabel('Option price (£)','FontSize',14)
        xlim([Smin Smax])
        legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
        sp = sp + 1;
    end

end