function delta = pathRecycling(S0, K, r, T, sigma, N, payoff)
    payoff = @(S) exp(-r*T)*max(K-S,0);
    dX = randn(1,N);

    S_right = (S0+dS)*exp((r-0.5*sigma^2)+sigma*dX);
    V_right = mean(payoff(S_right));
    S_left = (S0-dS)*exp((r-0.5*sigma^2)+sigma*dX);
    V_left = mean(payoff(S_left));

    delta = (V_right-V_left)/(2*dS);
end