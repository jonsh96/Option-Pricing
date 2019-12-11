%% PRICING A PUT OPTION
SetParameters;

%% Plotting the local volatility model
PlotVolatility(Smin, Smax, T, volatility);

%% Local volatility and stoch. interest rates
fprintf("Pricing a put option with local volatility and time-dependent interest rates\n")
[times_local_put, prices_local_put, variances_local_put, sample_sizes_local_put] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, M, put_payoff, 0);
PlotMonteCarlo(Smin, Smax, prices_local_put, 0);
PrintResults(times_local_put, variances_local_put, sample_sizes_local_put)
PlotVariances(Smin, Smax, variances_local_put, 0);
max_sample_sizes_local_put = ceil(max(sample_sizes_local_put'));

%% Running the max sample size needed
fprintf("Pricing a put option with local volatility and time-dependent interest rates with a 0.05 95 percent confidence level\n")
[times_max_local_put, prices_max_local_put, variances_max_local_put, sample_sizes_max_local_put] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, max_sample_sizes_local_put, put_payoff, 0);
times = times_max_local_put'./max_sample_sizes_local_put
PlotMonteCarlo(Smin, Smax, prices_max_local_put, 0);
PrintResults(times_max_local_put, variances_max_local_put, sample_sizes_max_local_put);
PlotVariances(Smin, Smax, variances_max_local_put, 0);

%% Constant volatility and interest rates
fprintf("\nPricing a put option with constant volatility and interest rates\n")
[times_constant_put, prices_constant_put, variances_constant_put, sample_sizes_constant_put] = MonteCarlo(K, Smin, Smax, r(1), sigma(1), dt, T, M, put_payoff, 0);
PlotMonteCarlo(Smin, Smax, prices_constant_put, 0);
PrintResults(times_constant_put, variances_constant_put, sample_sizes_constant_put);
PlotVariances(Smin, Smax, sample_sizes_constant_put, 0);
max_sample_sizes_constant_put = ceil(max(sample_sizes_constant_put'));

%% Running the max sample size needed
fprintf("Pricing a put option with constant volatility and interest rates with a 0.05 95 percent confidence level\n")
[times_max_constant_put, prices_max_constant_put, variances_max_constant_put, sample_sizes_max_constant_put] = MonteCarlo(K, Smin, Smax, r(1), sigma(1), dt, T, max_sample_sizes_constant_put, put_payoff, 0);
times = times_max_constant_put'./max_sample_sizes_constant_put
PlotMonteCarlo(Smin, Smax, prices_max_constant_put, 0);
PrintResults(times_max_constant_put, variances_max_constant_put, sample_sizes_max_constant_put);
PlotVariances(Smin, Smax, variances_max_constant_put, 0);

%% PRICING A DOWN AND OUT BARRIER PUT OPTION
%% Local volatility and stoch. interest rates
fprintf("\nPricing a down and out barrier put option with local volatility and time-dependent interest rates\n")
[times_local_barrier, prices_local_barrier, variances_local_barrier, sample_sizes_local_barrier] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, M, barrier_payoff, barrier);
PlotMonteCarlo(Smin, Smax, prices_local_barrier, barrier);
PrintResults(times_local_barrier, variances_local_barrier, sample_sizes_local_barrier);
PlotVariances(Smin, Smax, variances_local_barrier, barrier);
max_sample_sizes_local_barrier = ceil(max(sample_sizes_local_barrier'));

%% Running the max sample size needed for Sb = 30
fprintf("\nPricing a down and out barrier put option with local volatility and time-dependent interest rates with a 0.05 95 percent confidence level\n")
[times_max_local_barrier, prices_max_local_barrier, variances_max_local_barrier, sample_sizes_max_local_barrier] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, max_sample_sizes_local_barrier, barrier_payoff, barrier);
times = times_max_local_barrier'./max_sample_sizes_local_barrier
PlotMonteCarlo(Smin, Smax, prices_max_local_barrier, barrier);
PrintResults(times_max_local_barrier, variances_max_local_barrier, sample_sizes_max_local_barrier);
PlotVariances(Smin, Smax, variances_max_local_barrier, barrier);

%% Running the max sample size needed for Sb = 0
[times_max, prices_max_local_barrier, variances_max_local_barrier, sample_sizes_max_local_barrier] = MonteCarlo(K, Smin, Smax, rate, volatility, dt, T, max_sample_sizes_local_barrier, barrier_payoff, 0);
times_max_local_barrier'./max_sample_sizes_local_barrier
PlotMonteCarlo(Smin, Smax, prices_max_local_barrier, 0);
PrintResults(times_max_local_barrier, variances_max_local_barrier, sample_sizes_max_local_barrier);
PlotVariances(Smin, Smax, variances_max_local_barrier, barrier);

%% Barrier delta for local volatility
BarrierDeltaComparison(Smin, Smax, rate, volatility, dt, T, max_sample_sizes_local_barrier(2), barrier_payoff);

%% Local volatility and time-dependent interest rates - different barriers, Sb, ranging from 0-50 (5:8:45)
BarrierComparison(Smin, Smax, rate, volatility, dt, T, max_sample_sizes_local_barrier(2), barrier_payoff);

%% Constant volatility and interest rates - different barriers, Sb, ranging from 0-50 (5:8:45)
BarrierComparison(Smin, Smax, r(1), sigma(1), dt, T, max_sample_sizes_local_barrier(2), barrier_payoff);

%% Constant volatility and interest rates
fprintf("\nPricing a down and out barrier put option with constant volatility and interest rates\n")
[times, prices, variances, sample_sizes] = MonteCarlo(K, Smin, Smax, rate(0), sigma(1), dt, T, M, barrier_payoff, barrier);
PlotMonteCarlo(Smin, Smax, prices, barrier);
PrintResults(times, variances, sample_sizes)
PlotVariances(Smin, Smax, variances, barrier);

%% Antithetic delta
delta = AntitheticDelta(max_sample_sizes_local_barrier(2), rate, volatility, dt, T, Smin, Smax, barrier_payoff, barrier);
PlotDelta(Smin,Smax,delta);

