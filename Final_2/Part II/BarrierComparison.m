function BarrierComparison(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff)
    % TODO: COMMENT
    sp = 1; % Subplot counter
    for i = 5:8:45
        Sx = Smin:Smax;
        subplot(3,2,sp)
        [times, prices, variances, sample_sizes] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, M, option_payoff, i);
        plot(Sx,prices(1,Sx))
        hold on
        plot(Sx,prices(2,Sx))
        plot(Sx,prices(3,Sx))
        grid on
        titlestr = sprintf("Barrier option with S_b = £%d",i);
        title(titlestr,'FontSize',14)
        xlabel('Stock price (£)','FontSize',14)
        ylabel('Option price (£)','FontSize',14)
        xlim([Smin, Smax])
        legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
        sp = sp + 1;
    end
end