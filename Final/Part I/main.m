%% Initialising the values 
set_parameters

%% Finding J such that the error is < 0.05
J = minimizeAbsError(K1,K2,T,r,sigma,Smin,Smax,N,BS_bullspread)

%% Calculate the option prices numerically and with Black-Scholes
[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
V_BS = BS_bullspread(S); 
error = norm(V_PDE-V_BS,Inf)

%% Plotting the result
plotComparison(S, V_PDE, V_BS)

%% Monte-Carlo 
[times, prices, variances, errors, sample_sizes] = MonteCarloBullspread(Smin, Smax, K1, K2, r, sigma, T, N, payoff, BS_bullspread);

%% Plotting the different methods
plotMonteCarlo(Smin, Smax, prices, BS_bullspread)

%% Plotting the different methods
figure
for i = 1:4
    subplot(4,1,i)
    plotDifference(Smin, Smax, prices, i, BS_bullspread)
end

%% Printing the results
printResults(times, variances, errors, sample_sizes);

%% Plotting the results
plotResults(times, prices, variances, errors, sample_sizes);

% TODO: 
% - DELTA STUFF
% - COMMENTS
% - BUGFIX VARIANCE