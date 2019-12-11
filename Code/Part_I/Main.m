%% Initialising the values 
SetParameters;

%% Calculate the option prices numerically and with Black-Scholes and measure CPU time
start = cputime;
for i=1:M
    [V_PDE, S_PDE] = PDE_bullspread(K1, K2, T, rate, volatility, Smin, Smax, N, J);
end
time_PDE = (cputime-start)/M
V_BS = option_price(S_PDE); 
error_PDE = norm(V_PDE-V_BS,Inf)

%% Surface plot of the maximum absolute error
ErrorSurfacePlot(Smin, Smax, K1, K2, T, rate, volatility, option_price);

%% Error analysis of Smax for constant N and J
ErrorAnalysis(K1, K2, T, rate, volatility, Smin, Smax, N, J, option_price);

%% Plotting the result
PlotComparison(S_PDE, V_PDE, V_BS);

%% Normal delta
finDelta = FiniteDifferenceDelta(S_PDE,V_PDE);
CompareDelta(S_PDE, finDelta, option_delta);

%% Measurements of M = 1000 Monte Carlo simulations
[times, prices, variances, sample_sizes] = MonteCarlo([K1, K2], Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price, 0);
max_sample_sizes = ceil(max(sample_sizes'));

%% Running the max sample size needed and calculating the error
[times, prices, variances, sample_sizes] = MonteCarlo([K1, K2], Smin, Smax, rate, volatility, dt, T, max_sample_sizes, option_payoff, option_price, 0);

% Error
for i = 1:4
    error_MC(i) = norm(prices(i,:)-option_price(Smin:Smax),Inf);
end
% Printing the results
PrintResults(times, variances, sample_sizes, error_MC);   
% Plotting the different methods
PlotMonteCarlo(Smin, Smax, prices, option_price);

% Plotting the variances of the methods as a function of stock price
PlotVariances(variances);

%% Calculating the delta of the bull call spread with antithetic variance reduction
max_samples = ceil(max(sample_sizes'));
antiDelta = AntitheticDelta(max_samples(2), rate, volatility, dt, T, Smin, Smax, option_payoff);
PlotDelta(Smin, Smax, antiDelta, option_delta);
norm(antiDelta - option_delta(1:200), Inf)