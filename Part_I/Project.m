set_parameters;

J = minimizeAbsError(K1,K2,T,r,sigma,Smin,Smax,N);

[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);

V_BS = bullspread(S);
plot_comparison(S,V_BS,V_PDE);

%% DELTA

monte_carlo_bullspread;
compare_monte_carlo(price_BS, mean(price), mean(variance), mean(time), mean(errors), sample_size_mc)


% DELTA FOR MONTE CARLO