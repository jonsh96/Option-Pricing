% Initialising the values 
set_parameters;

% Finding J such that the error is < 0.05
J = minimizeAbsError(K1,K2,T,r,sigma,Smin,Smax,N);

% Calculate the option prices numerically and with Black-Scholes
[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
V_BS = BS_bullspread(S); 

% Plotting the result
%  plotComparison(S, V_PDE, V_BS)

% Monte-Carlo 
[times, prices, variances, errors, sample_sizes] = MonteCarloBullspread(Smin, Smax, K1, K2, r, sigma, T, 100000, payoff, BS_bullspread);
% plot(abs(errors(1,:)))

% Plotting the different methods
%plotMonteCarlo(Smin, Smax, prices)

% Plotting the different methods
for i = 1:4
    subplot(4,1,i)
    plotDifference(Smin, Smax, prices,i)
end

% Printing the results
printResults(times, prices, variances, errors, sample_sizes);

% TODO: 
% - DELTA STUFF
% - COMMENTS
% - BUGFIX VARIANCE