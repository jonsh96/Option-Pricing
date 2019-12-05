%% PRICING A PUT OPTION
SetParameters;

%% Local volatility and stoch. interest rates
fprintf("Pricing a put option with local volatility and stochastic interest rates\n")
[times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, rate, volatility, dt, T, M, put_payoff, 0);
figure
plot(prices(1,:))
hold on
plot(prices(2,:))
plot(prices(3,:))
plot(option_price,'k--','LineWidth',1.5)
grid on
title('Local volatility')
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
xlim([Smin Smax])
legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
printResults(times, variances, sample_sizes)
plotResults(times, prices, variances, sample_sizes);

%% Constant volatility and interest rates
fprintf("\nPricing a put option with constant volatility and interest rates\n")
[times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, r(1), sigma(1), dt, T, M, put_payoff, 0);
figure
plot(prices(1,:))
hold on
plot(prices(2,:))
plot(prices(3,:))
plot(option_price,'k--','LineWidth',1.5)
grid on
title('Constant volatility')
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
xlim([Smin Smax])
legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
printResults(times, variances, sample_sizes)
plotResults(times, prices, variances, sample_sizes);

%% PRICING A DOWN AND OUT BARRIER PUT OPTION
%% Local volatility and stoch. interest rates
fprintf("\nPricing a down and out barrier put option with local volatility and stochastic interest rates\n")
[times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff, 30);
figure
plot(prices(1,:))
hold on
plot(prices(2,:))
plot(prices(3,:))
grid on
title('Local volatility')
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
xlim([Smin Smax])
legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
printResults(times, variances, sample_sizes)
plotResults(times, prices, variances, sample_sizes);

%% Constant volatility and interest rates
fprintf("\nPricing a down and out barrier put option with constant volatility and interest rates\n")
[times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, r(1), sigma(1), dt, T, M, barrier_payoff, 0);
figure
plot(prices(1,:))
hold on
plot(prices(2,:))
plot(prices(3,:))
grid on
title('Constant volatility')
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
xlim([Smin Smax])
legend('Naive method','Antithetic variance reduction','Control variates','FontSize',14)
printResults(times, variances, sample_sizes)

%% Different Sb
sp = 1;
for i = 0:10:50
    [times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, r(1), sigma(1), dt, T, M, barrier_payoff, i);
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

