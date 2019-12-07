%% Initialising the values 
SetParameters;

%% Calculate the option prices numerically and with Black-Scholes
[V_PDE, S_PDE] = PDE_bullspread(K1, K2, T, rate, volatility, Smin, Smax, N, J);
V_BS = option_price(S_PDE); 
error = norm(V_PDE-V_BS,Inf);

%% Surface plot of the maximum absolute error
ErrorSurfacePlot(K1, K2, T, rate, volatility, Smin, Smax);

%% Plotting the result
PlotComparison(S_PDE, V_PDE, V_BS);

%% Error analysis of Smax for constant N and J
ErrorAnalysis(K1, K2, T, rate, volatility, Smin, Smax, N, J, option_price);

%% Measurements of M = 1000 Monte Carlo simulations
[times, prices, variances, sample_sizes] = MonteCarlo(K1, K2, Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price);

%% Printing the results
PrintResults(times, variances, sample_sizes);   

%% Plotting the different methods
PlotMonteCarlo(Smin, Smax, prices, option_price);

%% Plotting the different methods (not used in report)
figure
for i = 1:4
    subplot(4,1,i)
    PlotDifference(Smin, Smax, prices, i, option_price);
end

%% Plotting the sample sizes for each of the methods as a function of stock price
PlotSampleSizes(sample_sizes);

%% TODO: FIX DELTA
%% Normal delta
finDelta = FiniteDifferenceDelta(S_PDE,V_PDE);
plot(S_PDE(2:end), finDelta)
hold on
plot(S_PDE(2:end), option_delta(S_PDE(2:end)), 'o')

%% Calculating the delta of the bull call spread
antiDelta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff);
plotDelta(Smin, Smax, antiDelta, option_delta);
